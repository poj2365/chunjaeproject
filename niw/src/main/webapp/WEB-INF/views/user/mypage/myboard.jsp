<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }
    
    .content-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
    }
    
    .tabs {
        display: flex;
        border-bottom: 1px solid #eee;
        margin-bottom: 20px;
        overflow-x: auto;
    }
    
    .tab-item {
        padding: 15px 20px;
        cursor: pointer;
        transition: all 0.2s;
        white-space: nowrap;
    }
    
    .tab-item:hover {
        color: var(--bs-blind-dark);
    }
    
    .tab-item.active {
        font-weight: bold;
        color: var(--bs-blind-dark);
        border-bottom: 2px solid var(--bs-blind-dark);
    }
</style>

<div class="content-header">
    <h2 class="content-title">게시판 활동 내역 조회</h2>
</div>

<div class="tabs">
    <div class="tab-item active" data-tab="ARTICLE" onclick="changeActive(event)">작성한 게시글</div>
    <div class="tab-item" data-tab="COMMENTS" onclick="changeActive(event)">작성한 댓글</div>
    <div class="tab-item" data-tab="BOOKMARK" onclick="changeActive(event)">북마크한 글</div>
</div>

<article id="board-container">
	
</article>
<div id="board-pagebar">
	
</div>

<script>

	$(document).ready(loadData(1));

	function loadData(cPage) {
		const $container = $("#board-container");
		const $pageBar = $("#board-pagebar");
        let tab = $("div.tabs>div.active").data("tab");
        let url = "<%= request.getContextPath()%>";
        
        switch(tab){
            case 'ARTICLE': url += '/user/myarticle.do?cPage=' + cPage; break;
            case 'COMMENTS': url += '/user/mycomment.do?cPage=' + cPage; break;
            case 'BOOKMARK': url += '/user/mybookmark.do?cPage=' + cPage; break;
        }
        fetch(url, {
            method: "GET",
            headers: {
            	"Content-type":"application/json;charset=utf-8"
            }
        })
        .then(response => {
			if(response.ok){
				return response.json();
			} else {
				throw new Error('myboard load fail');
			}
		})
		.then(data => {
			const list = data['list'];
			$container.html("");
			const pageBar = data['pageBar'];
			$pageBar.html("");
			$pageBar.append(pageBar);
			switch(tab){
				case 'ARTICLE' :
					if(list.length > 0){
						for(let article of list) $container.append(getArticle(article)).append($("<hr>"));
					}
					else $container.append($("<div>").addClass("text-center").append($("<b>").text("조회된 결과가 없습니다."))).append($("<hr>"));
					break;
	            case 'COMMENTS' :
	            	if(list.length > 0){
	            		for(let comment of list) $container.append(getComment(comment)).append($("<hr>"));
	            	}
	            	else $container.append($("<div>").addClass("text-center").append($("<b>").text("조회된 결과가 없습니다."))).append($("<hr>"));
	            	break;
	            case 'BOOKMARK' :
	            	if(list.length > 0){
	            		for(let article of list) $container.append(getArticle(article)).append($("<hr>"));
	            	} else $container.append($("<div>").addClass("text-center").append($("<b>").text("조회된 결과가 없습니다."))).append($("<hr>"));
	            	break;
			}
		})
	}

	function changeActive(e) {
		$(".tab-item").toArray().forEach(t => {
			t.classList.remove("active");
		});
		$(e.target).addClass("active");
		loadData(1);
	}
	
	function getComment(comment) {
		const $form = $("<div>").addClass("align-item-center").css("min-width", "800px")
		const $name = $("<div>").addClass("mb-3").text(comment['userId']);
		const $container = $("<div>").addClass("align-items-center mb-3").text(comment['commentContent']);
		const $bot = $("<div>").addClass("row flex-row justify-content-between align-items-center");
		const $info = $("<div>").addClass("row flex-row col-lg-8").css("color", "gray");
		const $date = $("<span>").addClass("me-3 col-lg-3").text(timeFormat(comment['commentDateTime']));
		const $likes = $("<span>").addClass("me-3 col-lg-2 ")
				.append($("<i>").addClass("bi-hand-thumbs-up").text(comment['commentLikes']));
		const $dislikes = $("<span>").addClass("col-lg-2")
				.append($("<i>").addClass("bi-hand-thumbs-up").text(comment['commentDislikes']));
		const $button = $("<button>").addClass("text-end btn btn-primary col-lg-1 text-center").text("이동").on("click", () => {
			location.assign(getContextPath() + "/board/boarddetail.do?articleId=" + comment['articleId']);
		})
		$info.append($date).append($likes).append($dislikes);
		$bot.append($info).append($button);
		$form.append($name).append($container).append($bot);
		return $form;
	}
	
	function getArticle(article) {
		const $form = $("<div>").addClass("row flex-row justify-content-between align-item-center").css("min-width", "800px");
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
			"<%= request.getContextPath() %>" + "/board/boarddetail.do?articleId=" + article['articleId']
		)
		$a.html(article['articleTitle']);
		$title.append($a);
		$container.append($title);const $info = $("<ul>").addClass("list-unstyled row flex-row g-1 col-lg-6");
		
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
		$date.text(timeFormat(article['articleDateTime']));
		$info.append($date);
		$form.append($container).append($info);
		return $form;
	}
	
	
	
	function timeFormat(datetime) {
		const ldt = new Date(datetime);
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
	
	
	function getContextPath() {
		return "/" + window.location.pathname.split("/")[1];
	}
</script>
