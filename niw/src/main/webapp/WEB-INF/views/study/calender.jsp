<%@page import="com.niw.study.model.dto.Calendar"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<% List<Calendar> calendarList = (List<Calendar>) request.getAttribute("calendar");%>
<style>
.cal-container {
	padding: 20px;
	margin: 0 auto;
	max-width: 1000px;
}
/* modal */
.modal {
	display: none;
	position: fixed;
	z-index: 999;
	padding-top: 40px;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: #fff;
	margin: 0 auto;
	padding: 30px;
	border-radius: 10px;
	width: 90%;
	max-width: 700px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.close {
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

form input, form textarea {
	width: 30vw;
	padding: 10px;
	margin-top: 5px;
	box-sizing: border-box;
	border-radius: 5px;
	border: 1px solid #ccc;
}

form button[type="submit"] {
	background-color: #76c043;
	border: none;
	color: white;
	padding: 12px 20px;
	margin-top: 10px;
	border-radius: 25px;
	cursor: pointer;
}

form button[type="submit"]:hover {
	background-color: #5ea137;
}
/* modal end */
</style>
<section>
	<div class="cal-container">
		<div id='calendar'></div>
	</div>

	<div id="applyModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>일정 입력</h2>
			<form id="applyForm">
				<label>일정명<br> <input type="text" name="name" id="name" required /></label><br>
				<br> <label>상세 내용<br> <textarea name="content" id="content"
						rows="4"></textarea></label><br> <br> <label>시작일<br>
					<input type="date" name="start-time" id="start" required /></label><br> <br>
				<label>종료일<br> <input type="date" name="end-time" id="end"
					required /></label><br> <br>
				<button type="submit">저장</button>
			</form>
		</div>
	</div>
</section>
<script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth',
                center: 'title',
                right: 'prev,next'
              },
              titleFormat: function (date) {
                  return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
              },
              selectable: true,
              select : function(arg){
            	  console.log(arg);
            	  document.getElementById("applyModal").style.display = "block";
            	  document.getElementById("start").value = arg.startStr;
              },
              eventClick : function(arg){
            	  console.log(arg);
            	  document.getElementById("applyModal").style.display = "block";
      		      document.getElementById('name').value = arg.title;
            	  document.getElementById("start").value = arg.startStr;
            	  document.getElementById("end").value = arg.endStr;
            	  
      		    const jsonData = {
    		    		startTime: startStr,
    		    		userId: userId
    		    };
            	  fetch("<%=request.getContextPath()%>/study/calendarsearchbydate.do",{
            		method: 'POST',
      		        headers: {
      		            'Content-Type': 'application/json'
      		        },
      		        body: JSON.stringify(jsonData)
      		    }).then(response => {
    		        if (response.ok) {
    		            alert('전송 성공');
    		            location.replace(location.href);
    		        } else {
    		            alert('전송 실패');
    		            location.replace("<%=request.getContextPath()%>");
    		        }
    		    })
              },
              events : [
            	  <%if (calendarList != null) {%>
                  <%for (Calendar c : calendarList) {%>
            	  {
            		title : '<%=c.calendarName()%>',
            		start : '<%=c.startTime()%>',
            		end : '<%=c.endTime()%>'
            	  },
            	  <% }
            	  }%>
            	  ]
        });
        calendar.render();
      });
      
      // modal
      function closeModal(){
    	    document.getElementById("applyModal").style.display = "none";
    	  }

    	  // ESC 키
    	  window.addEventListener("keydown", function (e) {
    	    if (e.key === "Escape") closeModal();
    	  });

    	  $(document).mouseup(function(e) {
    		  const modal = $("#applyModal");
    		  if(modal.has(e.target).length===0){
    			  closeModal();
    		  }
    	  });
    	  document.getElementById('applyForm').addEventListener('submit', function(e) {
    		    e.preventDefault();

    		    const name = document.getElementById('name').value;
    		    const content = document.getElementById('content').value;
    		    const startDate = document.getElementById('start').value;
    		    const endDate = document.getElementById('end').value;
    		    const userId = "user_0001";

    		    const jsonData = {
    		    		calendarName : name,
    		    		calendarContent : content,
    		    		startTime: startDate,
    		    		endTime: endDate,
    		    		userId: userId
    		    };

    		    fetch("<%=request.getContextPath()%>/study/calendarsave.do",{
    		        method: 'POST',
    		        headers: {
    		            'Content-Type': 'application/json'
    		        },
    		        body: JSON.stringify(jsonData)
    		    })
    		    .then(response => {
    		        if (response.ok) {
    		            alert('전송 성공');
    		            location.replace(location.href);
    		        } else {
    		            alert('전송 실패');
    		            location.replace("<%=request.getContextPath()%>");
    		        }
    		    })
    		    .catch(err => {
    		        console.error(err);
    		        alert('에러 발생');
    		        location.replace("<%=request.getContextPath()%>");
    		    });
    		    closeModal();
    		});
    </script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>