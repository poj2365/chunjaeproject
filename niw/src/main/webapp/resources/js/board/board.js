
const getContextPath = () => {
	return "/" + window.location.pathname.split("/")[1];
}

const activeChange = (e, url) => {
	$("#category > li").toArray().forEach(li => {
	    li.classList.remove("active");
	});
	$(e.target.parentNode).addClass("active");
	searchArticle('1', url);
}


const searchArticle = (cPage, url) => {
	const category = $("#category>li.active>a")[0].getAttribute('data-category');
	const order = $("#order")[0].value;
	const numPerPage = $("#numPerPage")[0].value;
	const likes = $("#likes")[0].value;
	let searchData = $("#search>input")[0].value;
	if(sessionStorage.getItem("flag") == null){
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
					url
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
			url
	) => {
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
	$a.text(article['articleTitle']);
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
	
	const $date = $("<li>").addClass("col-lg-6");
	$date.text(article['userId'] + ' \u00B7 ' + timeFormat(article['articleDateTime']));
	$info.append($date);
	
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

const createCommentWriter = () => {
	const $wrapper = $("<div>").addClass("mb-3 comment-writer");
	const $form = $("<form>").attr("action", ""); // 여기 댓글 삽입 서블릿 추가 필요
	const $topDiv = $("<div>").addClass("d-flex justify-content-between align-items-center");
	const $label = $("<label>")
	    .attr("for", "commentTextarea")
	    .addClass("form-label")
	    .text("댓글 작성");
	const $submit = $("<input>")
	    .attr({
	        type: "submit",
	        value: "작성"
	    })
	    .addClass("btn btn-primary");
	$topDiv.append($label, $submit);
	const $textarea = $("<textarea>")
	    .attr({
	        name: "comment",
	        id: "commentTextarea",
	        placeholder: "댓글을 입력하세요",
	        rows: 3
	    })
	    .addClass("form-control")
	    .css("margin-top", "5px");
	$form.append($topDiv, $textarea);
	const $hr = $("<hr>");
	$wrapper.append($form, $hr);
	return $wrapper;
}

const writeComment = (e, level) => {
	const $form = createCommentWriter();
	if(level == 0){
		const $container = $(e.target).closest("div.comment-header");
		if ($container.find(".comment-writer").length > 0) {
		    $container.find(".comment-writer").remove();
		} else {
		    $(".comment-writer").remove();
		    $container.append($form);
		    $form.find("textarea").focus();
		}
	} else if(level == 1){
		const $container = $(e.target).closest("div.comment");
        if($container.find(".comment-writer").length > 0){
            $container.find(".comment-writer").remove();
        } else{
            $(".comment-writer").remove();
            $container.append($form);
            $form.find("textarea").focus();
        }
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
			console.log(recommendFlag);
			console.log(recommend);
			console.log(changeArticle);
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
