
const getContextPath = () => {
	return "/" + window.location.pathname.split("/")[1];
}

const activeChange = (e) => {
	$("#category > li").toArray().forEach(li => {
	    li.classList.remove("active");
	});
	$(e.target.parentNode).addClass("active")	
	searchArticle();
}

const searchArticle = () => {
	const category = $("#category>li.active>a")[0].getAttribute('data-category');
	console.log($("#category>li.active")[0]);
	console.log(category);
	console.log(getContextPath());
	const order = $("#order")[0].value;
	const numPerPage = $("#numPerPage")[0].value;
	const likes = $("#likes")[0].value;
	const search = $("#search>input")[0].value;
	const restrictData = {"category":category, "search":search, "order":order, "numPerPage": numPerPage, "likes":likes};
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
		$article.html = "";
		const $pageBar = $("#page-bar");
		$pageBar.html = "";
		
	}
	)
}

const getArticle = () => {
	const $form = $("<div>").addClass("row flex-row justify-content-between align-item-center");
	const $category = $("<span>").addClass("col-lg-1");
	const $title = $("<span>").addClass("col-lg-7");
	const $info = $("<span>").addClass("col-lg-3");
	$form.appendChild($category).appendChild($title).appendChild($info);	
	return $form;
}