<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="/WEB-INF/views/common/header.jsp" %>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
    <style>
    .cal-container{
    	padding : 20px;
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
    background-color: rgba(0,0,0,0.5);
  }

  .modal-content {
    background-color: #fff;
    margin: auto;
    padding: 30px;
    border-radius: 10px;
    width: 90%;
    max-width: 700px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  }

  .close {
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
  }

  form input, form textarea {
    width: 100%;
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
      <label>일정명<input type="text" name="name" required /></label><br><br>
      <label>상세 내용<textarea name="content" rows="4"></textarea></label><br><br>
      <label>시작일<input type="date" name="start-time" required /></label><br><br>
      <label>종료일<input type="date" name="end-time" required /></label><br><br>
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
              }
        }); 
        calendar.render();
      });
      
      // modal
      function closeModal() {
    	    document.getElementById("applyModal").style.display = "none";
    	  }

    	  // ESC 키로도 닫히게
    	  window.addEventListener("keydown", function (e) {
    	    if (e.key === "Escape") closeModal();
    	  });

    	  // 폼 제출 시 예시 처리 (백엔드 연동 전용)
    	  document.getElementById("applyForm").addEventListener("submit", function (e) {
    		fetch("<%=request.getContextPath()%>/study/insesrtSchedule.do")
    	    e.preventDefault();
    	    alert("일정이 저장되었습니다.");
    	    closeModal();
    	    this.reset();
    	  });
    </script>
   <%@include file="/WEB-INF/views/common/footer.jsp" %>