<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<style>
.content-section {
	padding: 30px 0;
	background: #f8f9fa;
}

.board-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
	overflow: hidden;
	transition: all 0.3s ease;
}

.board-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.board-header {
	padding: 20px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	position: relative;
}

.board-header.best {
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.board-header.resource {
	background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.board-header.study {
	background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
}

.board-title {
	font-size: 1.3rem;
	font-weight: 600;
	margin-bottom: 0;
	display: flex;
	align-items: center;
}

.board-title i {
	margin-right: 10px;
	font-size: 1.5rem;
}

.board-content {
	padding: 0;
}

.post-item {
	padding: 15px 20px;
	border-bottom: 1px solid #f0f0f0;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.post-item:last-child {
	border-bottom: none;
}

.post-item:hover {
	background: #f8f9fa;
	padding-left: 25px;
}

.post-info {
	flex: 1;
}

.post-title {
	color: #333;
	text-decoration: none;
	font-weight: 500;
	font-size: 0.95rem;
	display: block;
	margin-bottom: 5px;
}

.post-title:hover {
	color: #4ecdc4;
}

.post-meta {
	font-size: 0.8rem;
	color: #888;
}

.post-stats {
	display: flex;
	gap: 15px;
	color: #666;
	font-size: 0.85rem;
}

.stat-item {
	display: flex;
	align-items: center;
	gap: 5px;
}

.ad-section {
	background: white;
	border-radius: 15px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	margin-bottom: 20px;
}

.ad-header {
	background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
	color: white;
	padding: 15px 20px;
	font-weight: 600;
}

.ad-content {
	padding: 20px;
	text-align: center;
}

.ad-banner {
	background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
	padding: 30px;
	border-radius: 10px;
	margin-bottom: 15px;
	color: #333;
}

.ad-banner h5 {
	font-weight: 700;
	margin-bottom: 10px;
}

@media ( max-width : 768px) {
	.search-input {
		font-size: 0.9rem;
		padding: 10px 45px 10px 15px;
	}
	.board-title {
		font-size: 1.1rem;
	}
	.post-title {
		font-size: 0.9rem;
	}
	.nav-menu .nav-link {
		margin: 5px;
		padding: 5px 10px;
	}
}
</style>

<!-- Main Content -->
<div class="content-section">
	<div class="container">
		<div class="row">
			<!-- Left Content -->
			<div class="col-lg-8">
				<!-- Best Posts -->
				<div class="board-card">
					<div class="board-header best">
						<h3 class="board-title">베스트</h3>
					</div>
					<div class="board-content best-container">
						<div class="post-item">
							<div class="post-info">
								<a href="#" class="post-title">데이터를 불러오고 있습니다...</a>
							</div>
						</div>
					</div>
				</div>

				<!-- Resource Board -->
				<div class="board-card">
					<div class="board-header resource">
						<h3 class="board-title">자료게시판</h3>
					</div>
					<div class="board-content">
						<div class="post-item">
							<div class="post-info">
								<a href="#" class="post-title">데이터를 불러오고 있습니다...</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Study Board -->
				<div class="board-card">
					<div class="board-header study">
						<h3 class="board-title">스터디 게시판</h3>
					</div>
					<div class="board-content studygroup">
						<div class="post-item">
							<div class="post-info">
								<a href="#" class="post-title">데이터를 불러오고 있습니다...</a>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Right Sidebar -->
			<div class="col-lg-4">
				<!-- Advertisement -->
				<div class="ad-section">
					<div class="ad-content">
						<div class="ad-banner">
							<h5>🎯 개발자 취업 완벽 가이드</h5>
							<p class="mb-2">
								코딩테스트부터 면접까지<br>한 번에 준비하세요!
							</p>
							<button class="btn btn-primary btn-sm">자세히 보기</button>
						</div>

						<div class="ad-banner">
							<h5>📚 온라인 강의 50% 할인</h5>
							<p class="mb-2">
								프로그래밍, 디자인, 마케팅<br>모든 강의 특가 진행중!
							</p>
							<button class="btn btn-success btn-sm">할인받기</button>
						</div>

					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<script>
    $(document).ready(function() {
    // 스터디 게시판 불러오기 -> study/main.jsp
    $.ajax({
    	  url: '<%=request.getContextPath()%>/study/groupmainlist.do',
    	  method: 'GET',
    	  success: function(data) {
    	    $('.studygroup').html(data);
    	  },
    	  error: function(xhr) {
    	    console.error("오류:", xhr.responseText);
    	  }
    	});
    
    // board
       loadArticle("");
    }); 

        // 광고 배너 클릭 이벤트
        document.querySelectorAll('.ad-banner button').forEach(function(btn) {
            btn.addEventListener('click', function() {
                location.assign("https://www.genia.academy/");
            });
            
       
	   });
</script>
    
    

<!-- board -->
<script>
	function getContextPath() {
		return "/" + window.location.pathname.split("/")[1];
	}


	const loadArticle = (searchData) => {
		fetch(getContextPath() + "/main/article.do", {
			method: "post",
			headers: {
				"Content-type":"application/json;charset=utf-8"
			},
			body: JSON.stringify(searchData)
		})
		.then(response => {
			if(response.ok){
				return response.json();
			} else {
				throw new Error('index loadArticle fail');
			}
		})
		.then(data => {
			const articles = data;
			const $container = $(".best-container");
			$container.html("");
			for(let article of articles) {
				console.log(article);
				const $ul = $("<ul>").addClass("post-item clickable-ul row flex-row")
									 .on("click", function() {
										 boardDetail(article['articleId']);
									 })
				const $title = $("<li>").addClass("post-title overflow-hidden col-lg-6 d-flex align-items-center");
				const $category = $("<span>").addClass("badge me-2");
				switch(article['articleCategory']){
					case 1: $category.addClass("bg-secondary").text("일반"); break;
					case 2: $category.addClass("bg-primary").text("질문"); break;
				}
				$title.append($category).append(" " + article['articleTitle']);
				$ul.append($title);
				$ul.append($("<li>").addClass("post-title col-lg-2").text(article['userId']))
				   .append($("<li>").addClass("post-title col-lg-2").text(timeFormat(article['articleDateTime'])));					
				$container.append($ul);
			}
		})
	}
	
	function boardDetail(articleId) {
		location.assign(getContextPath() + '/board/boarddetail.do?articleId=' + articleId);
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
</script>
	