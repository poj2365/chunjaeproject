
const getContextPath = () => {
	return "/" + window.location.pathname.split("/")[1];
}

const activeChange = (e, url) => {
	$("#category > li").toArray().forEach(li => {
	    li.classList.remove("active");
	});
	$(e.target).addClass("active");
	searchArticle('1', url);
}


const searchArticle = (cPage, url) => {
	const category = $("#category>li.active")[0].getAttribute('data-category');
	const order = $("#order")[0].value;
	const numPerPage = $("#numPerPage")[0].value;
	const likes = $("#likes")[0].value;
	let searchData = $("#search>input")[0].value;
	if(sessionStorage.getItem("flag") != null && sessionStorage.getItem("flag") == true){
		searchData = "";
	}
	const restrictData = {
		 "url": url,
		 "category":category,
		 "searchData":searchData,
		 "order":order,
		 "numPerPage": numPerPage,
		 "likes":likes,
		 "cPage":cPage
	 };
		 
	fetch(getContextPath() + url, {
		method: "post",
		headers: {
			"Content-type":"application/json;charset=utf-8"
		},
		body: JSON.stringify(restrictData)
	})
	.then(response => {
		if(response.ok){
			return response.json();
		} else {
			throw new Error('board entrance fail');
		}
	})
	.then(data => {
		const $article = $("#article-container");
		$article.html("");
		const articles = data["articles"];
		const userId = data["userId"];
		const userRole = data["userRole"];
		if(articles.length > 0){
			for(let article of articles){
				$article.append(getArticle(
					article, 
					category, 
					searchData,
					order, 
					numPerPage, 
					likes, 
					cPage,
					userId,
					userRole
				)).append($("<hr>"));
			}
		} else {
			$article.append($("<div>").addClass("text-center").append($("<b>").text("조회된 결과가 없습니다."))).append($("<hr>"));
		}
		const $pageBar = $("#page-bar");
		$pageBar.html(data["pageBar"]);
	}
	)
}

const searchFlag = (cPage, url) => {
	sessionStorage.setItem("flag", true);
	searchArticle(cPage, url);
}

const getArticle = (
			article, 
			category, 
			searchData,
			order, 
			numPerPage, 
			likes, 
			cPage,
			userId,
			userRole
	) => {
	console.log(article);
	const $form = $("<div>").addClass("row flex-row justify-content-between align-item-center");
	const $container = $("<div>").addClass("col-lg-6 d-flex align-items-center");
	const $category = $("<span>").addClass("badge me-3");
	if(article['articleCategory'] == 1) {
		$category.addClass("bg-secondary");
		$category.text("일반")
	} else if(article['articleCategory'] == 2){
		$category.addClass("bg-primary");
		$category.text("질문")
	} else{
		$category.addClass("bg-dark");
		$category.text("미분류")
	}
	$container.append($category);
	const $title = $("<span>").addClass("overflow-hidden");
	const $a = $("<a>").addClass("text-decoration-none text-black").attr("href", 
		getContextPath() + "/board/boarddetail.do?articleId="
					 + article['articleId'] + "&category="
					 + category + "&searchData="
					 + searchData + "&order="
					 + order + "&numPerPage="
					 + numPerPage + "&likes="
					 + likes + "&cPage="
					 + cPage					 
		)
	$a.html(article['articleTitle']);
	$title.append($a);
	$container.append($title);
	const $info = $("<ul>").addClass("list-unstyled row flex-row g-1 col-lg-6");
	
	const $views = $("<li>").addClass("col-lg-2");
	const $viewsIcon = $("<i>").addClass("bi-eye");
	$viewsIcon.text(article['articleViews']);
	$views.append($viewsIcon);
	$info.append($views);
	
	const $likes = $("<li>").addClass("col-lg-2"); 
	const $likesIcon = $("<i>").addClass("bi-hand-thumbs-up");
	$likesIcon.text(article['articleLikes']);
	$likes.append($likesIcon);
	$info.append($likes);

	const $comment = $("<li>").addClass("col-lg-2"); 
	const $commentIcon = $("<i>").addClass("bi-chat");
	$commentIcon.text(article['commentCount']);
	$comment.append($commentIcon);
	$info.append($comment);
	
	const $date = $("<li>").addClass("col-lg-5");
	$date.text(article['userId'] + ' \u00B7 ' + timeFormat(article['articleDateTime']));
	$info.append($date);
	
	const $delete = $("<li>").addClass("col-lg-1");
	const $i = $("<i>", {
		class: "bi bi-x fw-bold border rounded-2 d-flex justify-content-center align-items-center",
	    css: {
	        width: "24px",
	        height: "24px",
	        cursor: "pointer",
	        fontStyle: "normal"
	    },
	    click: function () {
			const articleId = article['articleId'];
	        deleteArticle(articleId, "/board/boardentrance.do?category=0");
	    }
	});
	if(userId != null && userId.trim() != "" && (article['userId'] == userId || userRole == 'ADMIN')) $delete.append($i);
	
	$info.append($delete);
	$form.append($container).append($info);
	return $form;
}

const timeFormat = (articleDatetime) => {
	const ldt = new Date(articleDatetime);
	const now = new Date();
	if(!(ldt.toDateString() === now.toDateString())){
		return ldt.toISOString().split("T")[0];
	}
	const diffMs = now - ldt;
	const diffSec = Math.floor(diffMs / 1000);
	const diffMin = Math.floor(diffSec / 60);
	const diffHr = Math.floor(diffMin / 60);
	if (diffHr > 0) return diffHr + '시간전';
	if (diffMin > 0) return diffMin + '분전';
	return diffSec + '초전';
}

const createCommentWriter = (level, url, targetId) => {
	const $wrapper = $("<div>").addClass("mb-3 comment-writer");
	const $form = $("<form>");
	$form.attr("action", getContextPath() + "/board/savecomment.do");
	const $topDiv = $("<div>").addClass("d-flex justify-content-between align-items-center");
	const $label = $("<label>")
	    .attr("for", "commentTextarea")
	    .addClass("form-label")
	    .text("댓글 작성");
	const $url = $("<input>")
		.attr({
			type: "hidden",
			name: "url",
			value: url
		})
	const $level = $("<input>")
		.attr({
			type: "hidden",
			name: "level",
			value: level
		})
	const $targetId = $("<input>")
		.attr({
			type: "hidden",
			name: "targetId",
			value: targetId
		})
	const $submit = $("<input>")
			.attr({
			    type: "submit",
			    value: "작성"
				})
			.addClass("btn btn-primary");
	$topDiv.append($label, $submit, $url, $level, $targetId);
	const $textarea = $("<textarea>")
	    .attr({
	        name: "commentTextarea",
	        id: "commentTextarea",
	        placeholder: "댓글을 입력하세요",
	        rows: 3
	    })
	    .addClass("form-control")
	    .css("margin-top", "5px")
	$form.append($topDiv, $textarea);
	const $hr = $("<hr>");
	$wrapper.append($form, $hr);
	return $wrapper;
}

const writeComment = (e, level, userId, url) => {
	if(userId != null && userId.trim() != ""){
		if(level == 0){
			const $container = $(e.target).closest("div.comment-header");
			const targetId = $(e.target).data("target-id");
			const $form = createCommentWriter(level, url, targetId);
			if ($container.find(".comment-writer").length > 0) {
			    $container.find(".comment-writer").remove();
			} else {
			    $(".comment-writer").remove();
			    $container.append($form);
			    $form.find("textarea").focus();
			}
		} else if(level == 1){
			const $container = $(e.target).closest("div.comment");
			const targetId = $(e.target).data("target-id");
			const $form = createCommentWriter(level, url, targetId);
		    if($container.find(".comment-writer").length > 0){
		        $container.find(".comment-writer").remove();
		    } else{
		        $(".comment-writer").remove();
		        $container.append($form);
		        $form.find("textarea").focus();
		    }
		}
	} else {
		alert("로그인이 필요한 기능입니다.");
	}
}

const saveBookmark = (userId, articleId) => {
	if(userId != null){
		const bookmarkFlag = $("#bookmark")[0].getAttribute('data-flag');
		fetch(getContextPath() + "/board/savebookmark.do", {
			method: "post",
			headers: {
				"Content-type":"application/json;charset=utf-8"
			},
			body: JSON.stringify({
				"bookmarkFlag": bookmarkFlag,
				"userId":userId, 
				"articleId":articleId
			})
		})
		.then(response => {
			if(response.ok){
				return response.json();
			} else {
				throw new Error('bookmark fail');
			}
		})
		.then(data => {
			const result = data['result'];
			const bookmarkFlag = data['bookmarkFlag'];
			if(result > 0){
				const $bookmark = $("#bookmark");
				const $i = $($bookmark).find("i");
				if(bookmarkFlag == '0'){
					$bookmark.attr('data-flag', '1');
					$bookmark.addClass("btn-outline-warning");
					$i.removeClass("bi-bookmark");
					$i.addClass("bi-bookmark-fill");
				} else{
					$bookmark.attr('data-flag', '0');
					$i.addClass("bi-bookmark");
					$i.removeClass("bi-bookmark-fill");
					$bookmark.removeClass("btn-outline-warning");
				}
			}
		})
	} else {
		alert("로그인이 필요한 기능입니다.");
	}
}

const saveReport = () => {
	const $form = $("#reportForm");
	const userId = $form.find("#reportUserId").val();
	if(userId != null && userId.trim() !== ""){
		const targetId = $form.find("#reportTargetId").val();
		const targetType = $form.find("#reportTargetType").val();
		const reason = $form.find("#reportReason").val();
		if(reason != null && reason.trim() !== ""){
			const details = $form.find("#reportDetails").val();
			fetch(getContextPath() + "/board/report.do", {
				method: "post",
				headers: {
					"Content-type":"application/json;charset=utf-8"
				},
				body: JSON.stringify({
					"userId":userId,
					"targetId":targetId,
					"targetType":targetType,
					"reason":reason,
					"details":details
				})
			})
			.then(response => {
				if(response.ok){
					return response.json();
				} else {
					throw new Error('report fail');
				}
			})
			.then(data => {
				const reportFlag = data['reportFlag'];
				const report = data['report'];
				if(reportFlag == '0' && report == '1'){
					alert("신고가 접수되었습니다.")
					const modal = bootstrap.Modal.getInstance($('#reportModal')[0]);
					modal.hide();
					$reportButton.setAttribute("disabled", true);
				} 
			})
		} else {
			alert('신고 사유를 선택해주세요');
		}
	} else {
		alert("로그인이 필요한 기능입니다.");
	}
}

const insertRecommend = (e, recType, boardType, userId) => {
	if(userId != null && userId.trim() != ""){
		const $span = $(e.target).closest("span[data-target-id]");
		const targetId = $span[0].getAttribute("data-target-id");
		fetch(getContextPath() + "/board/recommend.do", {
			method: "post",
			headers: {
				"Content-type":"application/json;charset=utf-8"
			},
			body: JSON.stringify({
				"recType":recType,
				"boardType":boardType,
				"targetId":targetId
			})
		})
		.then(response => {
			if(response.ok){
				return response.json();
			} else {
				throw new Error('recommend fail');
			}
		})
		.then(data => {
			const recommendFlag = data['recommendFlag'];
			const recommend = data['recommend'];
			const changeArticle = data['changeArticle'];

			if(recType == '1'){
				if(changeArticle > 0 && recommend > 0){
					if(recommendFlag == 0){
						$span.find("i")[0].innerText =Number($span.find("i")[0].innerText)+1;
						$span.find("i").addClass("bi-hand-thumbs-up-fill");
						$span.find("i").removeClass("bi-hand-thumbs-up");
					} else{
						$span.find("i")[0].innerText =Number($span.find("i")[0].innerText)-1;
						$span.find("i").removeClass("bi-hand-thumbs-up-fill");
						$span.find("i").addClass("bi-hand-thumbs-up");					
					}
				} else {
					throw new Error("recommend fail");
				}
			} else {
				if(changeArticle > 0 && recommend > 0){
					if(recommendFlag == 0){
						$span.find("i")[0].innerText =Number($span.find("i")[0].innerText)+1;
						$span.find("i").addClass("bi-hand-thumbs-down-fill");
						$span.find("i").removeClass("bi-hand-thumbs-down");
					} else{
						$span.find("i")[0].innerText =Number($span.find("i")[0].innerText)-1;
						$span.find("i").removeClass("bi-hand-thumbs-down-fill");
						$span.find("i").addClass("bi-hand-thumbs-down");					
					}
				} else {
					throw new Error("recommend fail");
				}

			}
		})		
	} else {
		alert("로그인이 필요한 기능입니다.");
	}
}

const checkLogin = (flag) =>{
	if(!flag){
		alert("로그인이 필요한 기능입니다.");
		return false;
	}
	return true;
}

const deleteArticle = (articleId, url) => {
	const deleteConfirm = confirm("정말로 삭제하시겠습니까?");
	if(deleteConfirm){
		fetch(getContextPath() + "/board/deletearticle.do", {
			method: "POST",
			headers: {
				"Content-type":"application/json;charset=utf-8"
			},
			body: JSON.stringify({"articleId":articleId})
		})
		.then(response => {
			if(response.ok){
				return response.json();
			} else {
				throw new Error('article delete fail');
			}
		})
		.then(data => {
			const flag = data['flag'];
			if(flag == '1') alert('삭제가 완료되었습니다.');
			else alert('삭제가 실패하였습니다. 다시 시도해주세요.');
			location.href = getContextPath() + url;
		})
	}
}

	

const deleteComment = (commentId, articleId) => {
	const deleteConfirm = confirm("정말로 삭제하시겠습니까?");
		if(deleteConfirm){
			fetch(getContextPath() + "/board/deletecomment.do", {
				method: "POST",
				headers: {
					"Content-type":"application/json;charset=utf-8"
				},
				body: JSON.stringify({"commentId":commentId})
			})
			.then(response => {
				if(response.ok){
					return response.json();
				} else {
					throw new Error('comment delete fail');
				}
			})
			.then(data => {
				const flag = data['flag'];
				location.href = getContextPath() + '/board/boarddetail.do?articleId=' + articleId;
				if(flag == '1') {
					alert('삭제가 완료되었습니다.');
				}
				else {
					alert('삭제가 실패하였습니다. 다시 시도해주세요.');
				}
			})
		}
}

const updateComment = (e, commentId, articleId) => {
	const $comment = $(e.target).closest(".comment");
	const $original = $comment.clone(true);
	const rawContent = $comment.find("div.comment-content").text();
	const content = rawContent.replace(/^\s+|\s+$/g, '');
	$comment.empty();
	$comment.append(updateCommentWriter(content, commentId, articleId, $original));
}

const updateCommentWriter = (content, commentId, articleId, $original) => {
	const $wrapper = $("<div>").addClass("mb-3 comment-writer");
	const $form = $("<form>");
	$form.attr("action", getContextPath() + "/board/updatecomment.do");
	const $topDiv = $("<div>").addClass("d-flex justify-content-between align-items-center");
	const $label = $("<label>")
	    .attr("for", "commentTextarea")
	    .addClass("form-label")
	    .text("댓글 작성");
	const $formDiv = $("<div>");
	const $cancel = $("<button>")
			.attr({
				type: "button"
			})
			.addClass("btn btn-secondary me-2")
			.text("취소")
			.on("click", function () {
				const $comment = $(this).closest(".comment");
				$comment.replaceWith($original);
			});
	const $submit = $("<input>")
		.attr({
		    type: "submit",
		    value: "수정"
			})
		.addClass("btn btn-primary");
	const $commentId = $("<input>")
		.attr({
			type:"hidden",
			name:"commentId",
			value:commentId
		})
	const $articleId = $("<input>")
		.attr({
			type:"hidden",
			name:"articleId",
			value:articleId
		})
		
	$formDiv.append($cancel ,$submit, $commentId, $articleId);
	$topDiv.append($label, $formDiv);
	const $textarea = $("<textarea>")
	    .attr({
	        name: "commentTextarea",
	        id: "commentTextarea",
	        placeholder: "댓글을 입력하세요",
	        rows: 3
	    })
	    .addClass("form-control")
	    .css("margin-top", "5px")
		.val(content);
	$form.append($topDiv, $textarea);
	$wrapper.append($form);
	return $wrapper;
}



/*CKEditor */
/**
 * This configuration was generated using the CKEditor 5 Builder. You can modify it anytime using this link:
 * https://ckeditor.com/ckeditor-5/builder/?redirect=portal#installation/NoNgNARATAdCMAYKQCwGY0IBxQKxZQE5cBGEtKELBEXUghYwrEFE3QqIkZCAawD2yBGGAkwIkeKkBdSAGMARgBNlKEIQgygA
 */


const {
	ClassicEditor,
	Autoformat,
	AutoImage,
	Autosave,
	BlockQuote,
	Bold,
	CKBox,
	CKBoxImageEdit,
	CloudServices,
	Emoji,
	Essentials,
	Heading,
	ImageBlock,
	ImageCaption,
	ImageInline,
	ImageInsert,
	ImageInsertViaUrl,
	ImageResize,
	ImageStyle,
	ImageTextAlternative,
	ImageToolbar,
	ImageUpload,
	Indent,
	IndentBlock,
	Italic,
	Link,
	LinkImage,
	List,
	ListProperties,
	MediaEmbed,
	Mention,
	Paragraph,
	PasteFromOffice,
	PictureEditing,
	Table,
	TableCaption,
	TableCellProperties,
	TableColumnResize,
	TableProperties,
	TableToolbar,
	TextTransformation,
	TodoList,
	Underline
} = window.CKEDITOR;

const LICENSE_KEY =
	'eyJhbGciOiJFUzI1NiJ9.eyJleHAiOjE3NDk2ODYzOTksImp0aSI6ImQxMTRkMjdiLTFiZmQtNDE4ZS1hMjU0LTRlMTlkOWIwN2E3MiIsInVzYWdlRW5kcG9pbnQiOiJodHRwczovL3Byb3h5LWV2ZW50LmNrZWRpdG9yLmNvbSIsImRpc3RyaWJ1dGlvbkNoYW5uZWwiOlsiY2xvdWQiLCJkcnVwYWwiLCJzaCJdLCJ3aGl0ZUxhYmVsIjp0cnVlLCJsaWNlbnNlVHlwZSI6InRyaWFsIiwiZmVhdHVyZXMiOlsiKiJdLCJ2YyI6ImJmODNjMDMxIn0.uJpM5aOrJM_Hrc4XZNGA-CMpF33lXHZlmpGutt8aeWSI7XUbZxGc_MAQdvgsq6kjjMgHtRQhiEUCcDA7W1nLPg';

const CLOUD_SERVICES_TOKEN_URL =
	'https://ppqgdiyioua9.cke-cs.com/token/dev/cdb660b731234956a479c7c2b7fd019d528805c23c7b225ee7c5cfffe86d?limit=10';

const editorConfig = {
	
	toolbar: {
		items: [
			'undo',
			'redo',
			'|',
			'heading',
			'|',
			'bold',
			'italic',
			'line',
			'|',
			'emoji',
			'link',
			'insertImage',
			'ckbox',
			'mediaEmbed',
			'insertTable',
			'blockQuote',
			'|',
			'bulletedList',
			'numberedList',
			'todoList',
			'outdent',
			'indent'
		],
		shouldNotGroupWhenFull: false
	},
	plugins: [
		Autoformat,
		AutoImage,
		Autosave,
		BlockQuote,
		Bold,
		CKBox,
		CKBoxImageEdit,
		CloudServices,
		Emoji,
		Essentials,
		Heading,
		ImageBlock,
		ImageCaption,
		ImageInline,
		ImageInsert,
		ImageInsertViaUrl,
		ImageResize,
		ImageStyle,
		ImageTextAlternative,
		ImageToolbar,
		ImageUpload,
		Indent,
		IndentBlock,
		Italic,
		Link,
		LinkImage,
		List,
		ListProperties,
		MediaEmbed,
		Mention,
		Paragraph,
		PasteFromOffice,
		PictureEditing,
		Table,
		TableCaption,
		TableCellProperties,
		TableColumnResize,
		TableProperties,
		TableToolbar,
		TextTransformation,
		TodoList,
		Underline
	],
	cloudServices: {
		tokenUrl: CLOUD_SERVICES_TOKEN_URL
	},
	heading: {
		options: [
			{
				model: 'paragraph',
				title: 'Paragraph',
				class: 'ck-heading_paragraph'
			},
			{
				model: 'heading1',
				view: 'h1',
				title: 'Heading 1',
				class: 'ck-heading_heading1'
			},
			{
				model: 'heading2',
				view: 'h2',
				title: 'Heading 2',
				class: 'ck-heading_heading2'
			},
			{
				model: 'heading3',
				view: 'h3',
				title: 'Heading 3',
				class: 'ck-heading_heading3'
			},
			{
				model: 'heading4',
				view: 'h4',
				title: 'Heading 4',
				class: 'ck-heading_heading4'
			},
			{
				model: 'heading5',
				view: 'h5',
				title: 'Heading 5',
				class: 'ck-heading_heading5'
			},
			{
				model: 'heading6',
				view: 'h6',
				title: 'Heading 6',
				class: 'ck-heading_heading6'
			}
		]
	},
	image: {
		toolbar: [
			'toggleImageCaption',
			'imageTextAlternative',
			'|',
			'imageStyle:inline',
			'imageStyle:wrapText',
			'imageStyle:breakText',
			'|',
			'resizeImage',
			'|',
			'ckboxImageEdit'
		]
	},
	initialData: typeof CKEDITOR_INITIAL_DATA !== 'undefined' ? CKEDITOR_INITIAL_DATA : '',
	language: 'ko',
	licenseKey: LICENSE_KEY,
	link: {
		addTargetToExternalLinks: true,
		defaultProtocol: 'https://',
		decorators: {
			toggleDownloadable: {
				mode: 'manual',
				label: 'Downloadable',
				attributes: {
					download: 'file'
				}
			}
		}
	},
	list: {
		properties: {
			styles: true,
			startIndex: true,
			reversed: true
		}
	},
	mention: {
		feeds: [
			{
				marker: '@',
				feed: [
					/* See: https://ckeditor.com/docs/ckeditor5/latest/features/mentions.html */
				]
			}
		]
	},
	placeholder: '내용을 입력하세요.',
	table: {
		contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells', 'tableProperties', 'tableCellProperties']
	}
};

configUpdateAlert(editorConfig);

ClassicEditor.create(document.querySelector('#editor'), editorConfig)
			 .then(editor => {
				$("form").submit(() => {
					$("#content").val(editor.getData());
				})
			 });

/**
 * This function exists to remind you to update the config needed for premium features.
 * The function can be safely removed. Make sure to also remove call to this function when doing so.
 */
function configUpdateAlert(config) {}