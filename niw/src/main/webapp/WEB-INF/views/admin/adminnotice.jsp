<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/45.1.0/ckeditor5.css" crossorigin>

<style>
	/*CKEditor */
	.ck-content {
		font-family: 'Lato';
		line-height: 1.6;
		word-break: break-word;
	}
	
	.ck-editor__editable {
        min-height: 400px;
	}
    /* 마이페이지 전용 스타일 */
    .mypage-container {
        max-width: 1400px; /* 1200px → 1400px로 증가 */
        margin: 30px auto;
        display: flex;
        gap: 30px; /* 20px → 30px로 증가 */
        flex: 1;
        padding: 0 20px; /* 15px → 20px로 증가 */
    }
    
    /* 사이드바 스타일 */
    .sidebar {
        width: 260px; /* 240px → 220px로 축소 */
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 20px 0;
        flex-shrink: 0; /* 사이드바 크기 고정 */
    }
    
    .profile-section {
        padding: 0 20px 20px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }
    
    .profile-pic {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background-color: #f0f0f0;
        margin: 0 auto 15px;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
        border: 3px solid var(--bs-primary-light);
    }
    
    .profile-pic img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .user-id {
        font-weight: bold;
        margin-bottom: 5px;
        font-size: 18px;
        color: #333;
    }
    
    .user-name {
        color: #666;
        margin-bottom: 10px;
    }
    
    .point-info {
        font-size: 16px;
        color: var(--bs-blind-dark);
        margin-top: 10px;
        font-weight: bold;
    }
    
    .menu-section {
        padding: 20px 0;
    }
    
    .menu-title {
        padding: 0 20px;
        margin-bottom: 10px;
        font-size: 14px;
        color: #888;
        font-weight: bold;
    }
    
    .menu-item {
        padding: 12px 20px;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        cursor: pointer;
    }
    
    .menu-item i {
        margin-right: 10px;
        font-size: 18px;
    }
    
    .menu-item:hover {
        background-color: var(--bs-primary-light);
        color: var(--bs-blind-dark);
    }
    
    .menu-item.active {
        background-color: var(--bs-primary-light);
        color: var(--bs-blind-dark);
        border-left: 3px solid var(--bs-blind-dark);
        font-weight: bold;
    }
    
    /* 메인 컨텐츠 스타일 */
    .main-content {
        flex: 1;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 30px;
        min-height: 450px;
    }
    
    .loading-content {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 400px;
        flex-direction: column;
        color: #888;
    }
    
    .loading-spinner {
        border: 4px solid #f3f3f3;
        border-top: 4px solid var(--bs-blind-dark);
        border-radius: 50%;
        width: 40px;
        height: 40px;
        animation: spin 1s linear infinite;
        margin-bottom: 20px;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .mypage-container {
            flex-direction: column;
        }
        
        .sidebar {
            width: 100%;
        }
    }
</style>

<!-- 메인 컨테이너 -->
<div id="main-container">
	<div class="d-flex justify-content-between align-items-center">
		<h2> 공지 </h2>
		<button class="btn btn-primary" onclick="loadNoticeWrite()"> 작성 </button>
	</div>
	<hr>
	<article id="notice-container">
		
	</article>
	<div id="notice-pagebar">
		
	</div>
</div>
<script>
	function getContextPath() {
		return "/" + window.location.pathname.split("/")[1];
	}
	
	
	function getNotice(notice) {
		const $form = $("<div>").addClass("row flex-row justify-content-between align-items-center").css("minWidth", "800px");
		const $main = $("<div>").addClass("col-lg-8 d-flex align-items-center");
		const $badge = $("<span>").addClass("badge bg-danger me-3").text("공지");
		const $title = $("<span>").addClass("overflow-hidden");
		const $a = $("<a>").addClass("text-decoration-none text-black")
					.attr("href", getContextPath() + "/board/noticedetail.do?noticeId=" + notice['noticeId'])
					.text(notice["noticeTitle"]);		
		$title.append($a);
		$main.append($badge).append($title);
		const $name = $("<ul>").addClass("list-unstyled row flex-row g-1 col-lg-2");

		const $delete = $("<li>").addClass("col-lg-2");
		const $icon = $("<i>").addClass("bi bi-x fw-bold border rounded-2 d-flex justify-content-center align-items-center")
							  .css({
							    width: "24px",
							    height: "24px",
							    cursor: "pointer",
							    fontStyle: "normal"
							  })
							  .attr("onclick", "deleteNotice('" + notice['noticeId'] + "')");
		$delete.append($icon);
		
		const $update = $("<li>").addClass("col-lg-2 me-1");
		const $iconu = $("<i>").addClass("bi bi-pencil fw-bold border rounded-2 d-flex justify-content-center align-items-center")
							  .css({
							    width: "24px",
							    height: "24px",
							    cursor: "pointer",
							    fontStyle: "normal"
							  })
							 .attr("onclick", "loadUpdateNotice('" + notice['noticeId'] + "')");
		$update.append($iconu);
		$name.append($("<li>").addClass("col-lg-6").append($("<b>").text("관리자")))
 			 .append($update)
			 .append($delete);
		$form.append($main).append($name);
		return $form;
	}
	
	function getWriter() {
		const $form = $("<form>").attr({
			"action": getContextPath() + "/board/saveNotice.do",
			"method": "post"
		})
		const $header = $("<div>").addClass("d-flex flex-column justify-content-end align-items-end mb-3");
		const $title = $("<input>").addClass("form-control col-lg-9").attr({
		    type: "text",
		    placeholder: "제목을 입력하세요",
		    name: "title"
		});
		const $button = $("<button>").attr("type", "submit").addClass("mb-2 col-lg-1 btn btn-primary").text("작성");
		$header.append($button).append($title);

		const $mainContainer = $("<div>").addClass("main-container");

		const $editorContainer = $("<div>")
		  .addClass("editor-container editor-container_classic-editor")
		  .attr("id", "editor-container");

		const $innerEditor = $("<div>").addClass("editor-container__editor");
		const $editor = $("<div>").attr("id", "editor");

		$innerEditor.append($editor);
		$editorContainer.append($innerEditor);
		$mainContainer.append($editorContainer);

		const $hiddenInput = $("<input>").attr({
		  type: "hidden",
		  id: "content",
		  name: "content"
		});
		$form.append($header).append($mainContainer).append($hiddenInput);
		return $form;
	}
</script>

<script>
	function deleteNotice(noticeId) {
		const deleteConfirm = confirm("정말로 삭제하시겠습니까?");
		if(deleteConfirm){
			fetch(getContextPath() + "/board/deleteNotice.do?noticeId=" + noticeId, {
				method: "GET",
	            headers: {
	            	"Content-type":"application/json;charset=utf-8"
	            }
			})
			.then(response => {
				if(response.ok){
					return response.json();
				} else {
					throw new Error('delete notice fail');
				}
			})
			.then(data => {
				if(data > 0){
					alert('공지 삭제에 성공하였습니다.')
				} else {
					alert('공지 삭제에 실패하였습니다.')
				}
				loadNotice(1);
			})
		}
	}

	function loadNoticeWrite() {
		const $container = $("#main-container");
		$container.html(getWriter());
		makeEditor("");
	}
	
	function loadUpdateNotice(noticeId) {
		
	}

	function loadNotice(cPage) {
		const $container = $("#notice-container");
		const $pageBar = $("#notice-pagebar");
		fetch(getContextPath() + "/admin/notice.do?cPage=" + cPage, {
            method: "GET",
            headers: {
            	"Content-type":"application/json;charset=utf-8"
            }
        })
        .then(response => {
			if(response.ok){
				return response.json();
			} else {
				throw new Error('adminnotice load fail');
			}
		})
		.then(data => {
			const notices = data['list'];
			$container.html("");
			const pageBar = data['pageBar'];
			$pageBar.html("");
			$pageBar.append(pageBar);
			if(notices.length > 0){
				for(let notice of notices) $container.append(getNotice(notice)).append($("<hr>"));
			} else {
				$container.append($("<div>").addClass("text-center").append($("<b>").text("조회된 결과가 없습니다."))).append($("<hr>"));
			}
		})
	}

	$(document).ready(loadNotice('1'));
</script>

<script src="https://cdn.ckeditor.com/ckeditor5/45.1.0/ckeditor5.umd.js" crossorigin></script>
<script src="https://cdn.ckeditor.com/ckeditor5/45.1.0/translations/ko.umd.js" crossorigin></script>
<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js" crossorigin></script>

<script>
/*CKEditor */
/*
 * This configuration was generated using the CKEditor 5 Builder. You can modify it anytime using this link:
 * https://ckeditor.com/ckeditor-5/builder/?redirect=portal#installation/NoNgNARATAdCMAYKQCwGY0IBxQKxZQE5cBGEtKELBEXUghYwrEFE3QqIkZCAawD2yBGGAkwIkeKkBdSAGMARgBNlKEIQgygA
 */

const makeEditor = () => {
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
		initialData: '',
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
	
	
	ClassicEditor.create(document.querySelector('#editor'), editorConfig)
	.then(editor => {
		$("form").submit(() => {
			$("#content").val(editor.getData());
		})
	});
}
</script>