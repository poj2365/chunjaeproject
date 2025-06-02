<%@page import="com.niw.user.model.dto.User"%>
<%@page import="com.niw.study.model.dto.TimeRecord"%>
<%@page import="com.niw.study.model.dto.Calendar"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="<%=request.getContextPath()%>/resources/js/jquery-3.7.1.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<%
List<Calendar> calendarList = (List<Calendar>) request.getAttribute("calendar");
List<TimeRecord> trList = (List<TimeRecord>) request.getAttribute("trList");
User loginUser= (User)session.getAttribute("loginUser");
%>
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

form button {
	background-color: #76c043;
	border: none;
	color: white;
	padding: 12px 20px;
	margin-top: 10px;
	border-radius: 25px;
	cursor: pointer;
}

form button:hover {
	background-color: #5ea137;
}

#updateForm {
	display: none;
}

#delete {
	background-color: red;
}
/* modal end */

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
        width:1000px;
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
<div class="cal-container">
		<div id='calendar'></div>
	</div>

	<div id="applyModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>일정 입력</h2>
			<form id="applyForm">
				<input type="hidden" id="no"> <label>일정명<br> <input
					type="text" name="name" id="name" required /></label><br> <br> 
					<label>상세 내용<br> <textarea name="content" id="content" rows="4"></textarea>
				</label><br> <br> 
				<label>시작일<br> <input type="date"
					name="start-time" id="start" required /></label><br> <br> 
					<label>종료일<br><!-- datetime-local -->
					<input type="date" name="end-time" id="end" required /></label><br> <br>
				<div id="insertForm">
					<button type="button" onclick="calendar('calendarsave');">저장</button>
				</div>
				<div id="updateForm">
					<button type="button" onclick="calendar('calendarupdate');">수정</button>
					<button type="button" id="delete"
						onclick="calendar('calendardelete');">삭제</button>
				</div>
			</form>
		</div>
	</div>
    </div>
</div>
</section>
<script>
const timeRecordTitle = [
    <% if (trList != null) {
         for (TimeRecord tr : trList) { %>
           "<%= tr.totalTime() %>",
    <%   }
       } %>
  ];

  	    // 사이드바 메뉴 클릭 이벤트
  	    $('.menu-item').on('click', function() {
  	        var $this = $(this);
  	        var tabId = $this.data('tab');
  	        if(tabId=="calendar"){
  	        	location.assign("<%=request.getContextPath() %>/study/calender.do");
  	        }else if(tabId=="record"){
  	        	location.assign("<%=request.getContextPath() %>/study/timerecord.do");
  	        }else if(tabId=="rank"){
  	        	location.assign("<%=request.getContextPath() %>/study/timeranking.do");
  	        }else if(tabId=="studygroup"){
  	        	location.assign("<%=request.getContextPath() %>/study/groupdetail.do");
  	        }else if(tabId=="grouplist"){
  	        	location.assign("<%=request.getContextPath() %>/study/grouplist.do");
  	        }
  	    });
  	  	
  	  function initCalendar() {
        var calendarEl = document.getElementById('calendar');
        <% if(loginUser==null){ %>
        var calendar = new FullCalendar.Calendar(calendarEl, {
            timeZone: 'UTC',
            initialView: 'dayGridMonth',
            selectable: true
          });
        <% }else{ %>
        const userId = '<%=loginUser.userId()%>';
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
            	  openModal();
            	  document.getElementById("no").value = "";
            	  document.getElementById("name").value = "";
            	  document.getElementById("content").textContent = "";
            	  document.getElementById("start").value = arg.startStr;
            	  document.getElementById("end").value = "";
		    	  document.getElementById("insertForm").style.display = "block";
		    	  document.getElementById("updateForm").style.display = "none";
              },
              eventClick : function(arg){
            	  if (timeRecordTitle.includes(arg.event.title)) {
            		    // 타임레코드이면 calendarsearchbydate.do 호출 안함
            		    return;
            		  }
            	  openModal();
            	  document.getElementById("content").textContent = "";
            	  document.getElementById("start").value = arg.event.startStr;

      		   const jsonData = {
    		    		startTime: arg.event.start,
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
    		            return response.json();
    		        }
    		        throw new Error('네트워크 응답이 올바르지 않습니다.');
    		    }).then(data=>{
    		    	document.getElementById("no").value = data.calendarNo;
        		    document.getElementById("name").value = arg.event.title;
              	  	document.getElementById("end").value = arg.event.endStr;
    		    	document.getElementById("insertForm").style.display = "none";
    		    	document.getElementById("updateForm").style.display = "block";
	    		    document.getElementById("content").textContent = data.calendarContent;
	    		    document.getElementById("start").value = formatDateToInput(data.startTime);
    		        if(arg.event.endStr == undefined || arg.event.endStr==""){
    		            document.getElementById("end").value = formatDateToInput(data.endTime);
    		            }
    		    }).catch(error=>{
    		    	console.log("에러발생"+error);
    		    	alert('일정 데이터를 불러오는데 실패하였습니다.');
    		    })
              },
              events : [
            	  <%if (trList != null) {%>
            	  <%for (TimeRecord tr : trList) {%>
            	  {
              		title : '<%=tr.totalTime()%>',
              		start : '<%=tr.startTime()%>',
              		end : '<%=tr.endTime()%>'
              	  },
              	  <%}
					}%>
            	  <%if (calendarList != null) {%>
                  <%for (Calendar c : calendarList) {%>
            	  {
            		title : '<%=c.calendarName()%>',
            		start : '<%=c.startTime()%>',
            		end : '<%=c.endTime()%>'
            	  },
            	  <%}
					}%>
            	  ]
        });
        <% } %>
        calendar.render();
      };
      
      function formatDateToInput(date) {
    	  const d = new Date(date);
    	  const year = d.getFullYear();
    	  const month = ('0' + (d.getMonth() + 1)).slice(-2); // 0부터 시작하므로 +1
    	  const day = ('0' + d.getDate()).slice(-2);
    	  return `\${year}-\${month}-\${day}`;
    	}
      
      // modal
      function closeModal(){
    	    document.getElementById("applyModal").style.display = "none";
    	  }
      
      function openModal(){
  	    document.getElementById("applyModal").style.display = "block";
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
			function calendar(path){
				const no = document.getElementById('no').value;
    		    const name = document.getElementById('name').value;
    		    const content = document.getElementById('content').value;
    		    const startDate = document.getElementById('start').value;
    		    const endDate = document.getElementById('end').value;
    		    const userId = '<%=loginUser.userId()%>';
				
    		    let jsonData = {}
    		    if(path=="calendarsave"){
    		    jsonData = {
    		    		calendarName : name,
    		    		calendarContent : content,
    		    		startTime: startDate,
    		    		endTime: endDate,
    		    		userId: userId
    		    };
    		    }else if(path=="calendarupdate"){
        		    jsonData = {
        		    		calendarNo : no,
        		    		calendarName : name,
        		    		calendarContent : content,
        		    		startTime: startDate,
        		    		endTime: endDate,
        		    		userId: userId
        		    };
    		    }else if(path=="calendardelete"){
        		    jsonData = {
        		    		calendarNo : no,
        		    		userId: userId
        		    };
    		    }
    		    fetch("<%=request.getContextPath()%>/study/"+path+".do",{
    		        method: 'POST',
    		        headers: {
    		            'Content-Type': 'application/json'
    		        },
    		        body: JSON.stringify(jsonData)
    		    })
    		    .then(response => {
    		        if (response.ok) {
    		            alert('일정 데이터가 정상적으로 저장되었습니다.');
    		            location.replace(location.href);
    		        } else {
    		            alert('일정 데이터를 저장하는데 실패하였습니다.');
    		            location.replace("<%=request.getContextPath()%>");
    		        }
    		    })
    		    .catch(err => {
    		        console.error(err);
    		        alert('일정 데이터를 저장하는데 에러가 발생하였습니다.');
    		        location.replace("<%=request.getContextPath()%>");
    		    });
    		    closeModal();
    		};
    </script>