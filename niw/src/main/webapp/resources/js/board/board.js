
const getContextPath = () => {
	return "/" + window.location.pathname.split("/")[1];
}

const activeChange = (e) => {
	$("#category > li").toArray().forEach(li => {
	    li.classList.remove("active");
	});
	$(e.target.parentNode).addClass("active");
	searchArticle('1');
}

let flag = false;

const searchArticle = (cPage) => {
	const category = $("#category>li.active>a")[0].getAttribute('data-category');
	const order = $("#order")[0].value;
	const numPerPage = $("#numPerPage")[0].value;
	const likes = $("#likes")[0].value;
	let searchData = $("#search>input")[0].value;
	if(!flag){
		searchData = "";
	}
	const restrictData = {
		 "category":category,
		 "searchData":searchData,
		 "order":order,
		 "numPerPage": numPerPage,
		 "likes":likes,
		 "cPage":cPage
	 };
		 
	fetch(getContextPath() + "/board/articlelist.do", {
		method: "post",
		header: {
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
		const category = $("#category>li.active>a")[0].getAttribute('data-category');
		const order = $("#order")[0].value;
		const numPerPage = $("#numPerPage")[0].value;
		const likes = $("#likes")[0].value;
		let searchData = $("#search>input")[0].value;
		for(let article of articles){
			$article.append(getArticle(
				article,
				category,
				order,
				numPerPage,
				likes,
				searchData
			)).append($("<hr>"));
		}
		const $pageBar = $("#page-bar");
		$pageBar.html(data["pageBar"]);
	}
	)
}

const searchFlag = (cPage) => {
	flag = true;
	searchArticle(cPage);
}


const getArticle = (
	article,
	category,
	order,
	numPerPage,
	likes,
	searchData
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
				 + category + "&order=" 
				 + order + "&numPerPage="
				 + numPerPage + "&likes="
				 + likes + "&searchData="
				 + searchData
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


