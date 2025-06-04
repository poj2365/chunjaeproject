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

.material-container .post-item {
    transition: all 0.2s ease;
}

.material-container .post-item:hover {
    background-color: #f8f9fa;
    transform: translateX(5px);
}

.material-container .badge {
    font-size: 0.7rem;
}

.material-container .post-stats {
    min-width: 200px;
    display: flex;
    gap: 10px;
    font-size: 0.8rem;
    color: #666;
}

.material-container .stat-item {
    display: flex;
    align-items: center;
    gap: 3px;
}

.material-container .stat-item i {
    font-size: 0.75rem;
}

@media (max-width: 768px) {
    .material-container .post-stats {
        min-width: auto;
        gap: 8px;
    }
    
    .material-container .stat-item {
        font-size: 0.75rem;
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
					<div class="board-content material-container">
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
    
    //material
       loadRecentMaterials();
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

<script>
function timeFormat2(datetime) {
	   console.log('입력값:', datetime);
	    
	    if (!datetime) {
	        return '등록일';
	    }
	    
	    const dateStr = datetime.toString();
	    console.log('문자열:', dateStr);
	    
	    // 모든 숫자를 추출 (4자리는 년도, 나머지는 월/일)
	    const numbers = dateStr.match(/\d+/g);
	    console.log('추출된 숫자들:', numbers);
	    
	    if (!numbers || numbers.length < 3) {
	        return '등록일';
	    }
	    
	    let year, month, day;
	    
	    // 4자리 숫자를 년도로 찾기
	    const yearIndex = numbers.findIndex(num => num.length === 4);
	    if (yearIndex !== -1) {
	        year = numbers[yearIndex];
	        // 년도를 제외한 나머지 숫자들
	        const otherNumbers = numbers.filter((_, index) => index !== yearIndex);
	        [month, day] = otherNumbers;
	    } else {
	        // 4자리 년도가 없으면 순서대로
	        [month, day, year] = numbers;
	    }
	    
	    console.log('년:', year, '월:', month, '일:', day);
	    
	    // 패딩 적용
	    year = year || new Date().getFullYear();
	    month = String(month).padStart(2, '0');
	    day = String(day).padStart(2, '0');
	    
	    const result = `\${year}-\${month}-\${day}`;
	    console.log('결과:', result);
	    
	    return result;
	}
function loadRecentMaterials() {
    $.ajax({
        url: '<%=request.getContextPath()%>/main/materials.do',
        method: 'GET',
        dataType: 'json',
        success: function(materials) {
            const $container = $('.material-container');
            $container.html('');
            
            if (materials && materials.length > 0) {
                materials.forEach(function(material) {
                    // 베스트와 동일한 ul > li 구조 사용
                    const $ul = $("<ul>").addClass("post-item clickable-ul row flex-row")
                                         .on("click", function() {
                                             // 자료 상세페이지로 이동
                                             location.href = '<%=request.getContextPath()%>/market/detail.do?materialId=' + material.materialId;
                                         });
                    
                    // 제목 + 카테고리 (col-lg-6)
                    const $title = $("<li>").addClass("post-title overflow-hidden col-lg-6 d-flex align-items-center");
                    const $category = $("<span>").addClass("badge me-2");
                    
                    // 카테고리 배지 설정
                    if (material.materialCategory) {
                        switch(material.materialCategory) {
                            case '초등학교':
                                $category.addClass('bg-success').text('초등학교');
                                break;
                            case '중학교':
                                $category.addClass('bg-info').text('중학교');
                                break;
                            case '고등학교':
                                $category.addClass('bg-warning').text('고등학교');
                                break;
                            default:
                                $category.addClass('bg-secondary').text(material.materialCategory);
                        }
                    } else {
                        $category.addClass('bg-secondary').text('자료');
                    }
                    
                    // 제목에 카테고리와 텍스트 추가
                    $title.append($category).append(" " + material.materialTitle);
                    $ul.append($title);
                    
                    // 작성자 (col-lg-2)
                    $ul.append($("<li>").addClass("post-title col-lg-2").text(material.instructorName || '작성자'));
                    
                    // 작성일 (col-lg-2) - 베스트와 동일한 timeFormat 함수 사용
                    console.log(material.materialUpdatedDate);
                 
                    const displayTime = timeFormat2(material.materialUpdatedDate);
                    console.log(displayTime);
                    $ul.append($("<li>").addClass("post-title col-lg-2").text(displayTime));
                    
                    $container.append($ul);
                });
            } else {
                // 자료가 없을 때도 베스트와 동일한 형식
                const $ul = $("<ul>").addClass("post-item row flex-row");
                const $title = $("<li>").addClass("post-title overflow-hidden col-lg-6 d-flex align-items-center");
                $title.text("등록된 자료가 없습니다.");
                $ul.append($title);
                $container.append($ul);
            }
        },
        error: function(xhr, status, error) {
            console.error('자료 목록 로드 실패:', error);
            const $container = $('.material-container');
            $container.html('');
            
            // 에러 시에도 베스트와 동일한 형식
            const $ul = $("<ul>").addClass("post-item row flex-row");
            const $title = $("<li>").addClass("post-title overflow-hidden col-lg-6 d-flex align-items-center");
            $title.text("자료를 불러오는데 실패했습니다.");
            $ul.append($title);
            $container.append($ul);
        }
    });
}
</script>

	