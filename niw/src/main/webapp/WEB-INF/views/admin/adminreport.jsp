<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!-- 초기 로딩 시 회원정보 표시 -->
<div class="report-container">
	<div class="loading-content">
	    <div class="loading-spinner"></div>
	    <p>페이지를 불러오는 중입니다...</p>
	</div>
</div>
<div class="report-pagebar">
	
</div>

<script>
	$(document).ready(loadReport('1'));
	
	function loadReport(cPage) {
		fetch(getContextPath() + "/board/searchReport.do?cPage=" + cPage, {
			method: "POST",
	        headers: {
	        	"Content-type":"application/json;charset=utf-8"
	        }
		})
		.then(response => {
			if(response.ok){
				return response.json();
			} else {
				throw new Error('load report fail');
			}
		})
		.then(data => {
			const reports = data['reports'];
			const pageBar = data['pageBar'];
			
			$(".report-pagebar").html(pageBar);
			const $container = $(".report-container");
			$container.html($("<h2>").text("신고 내역"));
			if(reports != null && reports.length > 0){
				for(let report of reports){
					console.log(report);
					$container.append(getReport(report)).append($("<hr>"));
				}
			} else {
				$container.append($("<div>").addClass("text-center").append($("<b>").text("조회된 결과가 없습니다."))).append($("<hr>"))
			}
			
		})
	}
	
	function getReport(report) {
		const $form = $("<div>").addClass("row flex-row justify-content-between align-item-center").css("min-width", "800px");
		const $container = $("<div>").addClass("col-lg-6 d-flex align-items-center");
		const $rType = $("<span>").addClass("badge me-3");
		if(report['reportType'] == 'spam') {
			$rType.addClass("bg-warning");
			$rType.text("스팸")
		} else if(report['reportType'] == 'abuse'){
			$rType.addClass("bg-danger");
			$rType.text("욕설")
		} else if(report['reportType'] == 'illegal'){
			$rType.addClass("bg-dark");
			$rType.text("불법")
		} else{
			$rType.addClass("bg-secondary");
			$rType.text("기타")
		}
		$container.append($rType);
		const $title = $("<span>").addClass("overflow-hidden me-2");
		if(report['boardType'] == 'ARTICLE') $title.text("[게시글] " + (report['reportContent'] == null? '상세내역 없음': report['reportContent']));
		else if(report['boardType'] == 'COMMENTS') $title.text("[댓글] " + (report['reportContent'] == null? '상세내역 없음': report['reportContent']));				
		$container.append($title);
		const $selector = $("<div>").addClass("d-flex justify-content-end align-items-center col-lg-4");
		const $button = $("<button>").addClass("btn btn-primary me-2")
									 .attr({
										 "type": "button"
										 })
									 .text("이동")
									 .on("click", function() {
										 		location.assign(getContextPath() + "/board/boarddetail.do?articleId=" + report['articleId']);
										});
		const $treat = $("<button>").addClass("btn btn-danger")
									.attr({
										 "type": "button"
										 })
									 .text("처리")
									 .on("click", function(){
										 deleteReport(report['reportId']);
									 });
		$selector.append($button).append($treat);
		$form.append($container).append($selector);
		return $form;
	}
	
	function deleteReport(reportId) {
		const deleteConfirm = confirm("신고내역을 처리하시겠습니까?");
		if(deleteConfirm){
			fetch(getContextPath() + "/board/deleteReport.do?reportId=" + reportId, {
				method: "GET",
	            headers: {
	            	"Content-type":"application/json;charset=utf-8"
	            }
			})
			.then(response => {
				if(response.ok){
					return response.json();
				} else {
					throw new Error('delete report fail');
				}
			})
			.then(data => {
				if(data > 0){
					alert('신고를 처리하였습니다.')
				} else {
					alert('신고 처리에 실패하였습니다.')
				}
				loadReport(1);
			})
		}
	}
</script>