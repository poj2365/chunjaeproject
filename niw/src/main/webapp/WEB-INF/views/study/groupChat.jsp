<%@page import="com.niw.study.model.dto.TimeRecord"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%
int groupNumber = (int) request.getAttribute("groupNumber");
%>
<style>
#chat-container {
  display: flex;
  flex-direction: column;
  height: 500px;
  border: 1px solid #ccc;
  border-radius: 8px;
  overflow: hidden;
  position: relative;
}

#msg-container {
  flex: 1;
  overflow-y: auto;
  padding: 15px;
  background: #f9f9f9;
}

.chat-message {
  max-width: 70%;
  margin-bottom: 12px;
  display: flex;
  flex-direction: column;
}

.chat-message.self {
  align-items: flex-end;
  margin-left: auto;
}

.chat-message.other {
  align-items: flex-start;
  margin-right: auto;
}

.chat-sender {
  font-size: 12px;
  color: #888;
  margin-bottom: 4px;
}

.chat-bubble {
  padding: 10px 14px;
  border-radius: 18px;
  background-color: #e0e0e0;
  word-break: break-word;
}

.chat-message.self .chat-bubble {
  background-color: #d0e6ff;
}

#msg-input-area {
  display: flex;
  padding: 10px;
  background: #fff;
  border-top: 1px solid #ccc;
}

#msg {
  flex: 1;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-right: 10px;
}

#send-btn {
  white-space: nowrap;
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
</style>
<section>
<!-- 메인 컨테이너 -->
<div class="mypage-container">
    <!-- 사이드바 영역 -->
    <div class="sidebar">
        <div class="profile-section">
            <div class="profile-pic">
                <i class="bi bi-person-circle" style="font-size: 60px; color: #ccc;"></i>
            </div>
            <% if(loginUser!=null){%>
            <div class="user-id"><%=loginUser.userId() %></div>
            <div class="user-name"><%=loginUser.userName() %></div>
            <div class="point-info">포인트:<%=loginUser.userPoint() %> P</div>
            <% }else{%>
            <div class="user-id">Guest</div>
           <%  }%>

        </div>
        <div class="menu-section">
            <div class="menu-title">스터디 그룹</div>
            <ul>
                <li class="menu-item active" data-tab="grouplist">
                    <i class="bi bi-person-plus"></i>스터디 모집
                </li>
                <li class="menu-item" data-tab="studygroup">
                    <i class="bi bi-people"></i>내 스터디 그룹
                </li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">공부</div>
            <ul>
            	<li class="menu-item" data-tab="record">
                    <i class="bi bi-clock"></i>공부 시간 기록
                </li>
                <li class="menu-item" data-tab="rank">
                    <i class="bi bi-trophy"></i>랭킹
                </li>
                <li class="menu-item" data-tab="calendar">
                    <i class="bi bi-calendar-check"></i>스터디 플래너
                </li>
            </ul>
        </div>
    </div>
    
    <!-- 메인 컨텐츠 영역 -->
    <div class="main-content">
		<div class="content-header">
    <h2 class="content-title">그룹 채팅</h2>
</div>
    <div id="chat-container">
        <div id="msg-container"></div>
  <div id="msg-input-area">
        <input type="text" id="msg" placeholder="메시지를 입력하세요">
        <button class="btn btn-outline-primary" id="send-btn">전송</button>
        </div>
    </div>
    </div>
    </div>
    </section>
    <script>
    const sender="<%=loginUser.userId()%>";
    const groupNumber = "<%=groupNumber%>";
    
    $(document).ready(() => {
        fetch("<%=request.getContextPath()%>/study/groupchathistory.do?groupNumber="+groupNumber)
        .then(response=>{
        	if(response.ok){
        		return response.json();
        	}
        }).then(data=>{
        	data.forEach(msg=>{
        		msgPrint(msg);
        	})
        }).catch(error => {
            console.error("데이터 불러오기 실패:", error);
        });
    });
    
        //접속요청을 서버에 보냄
        let socket=new WebSocket("ws://13.124.190.205:8080<%=request.getContextPath()%>/study/groupchat?groupNumber=" + groupNumber);
        //핸들러 등록하기
        socket.onopen=(response)=>{
            console.log(response);
            const sendTime = new Date().toISOString();
            const msg=new Message("A",groupNumber,sender,"",sendTime);
            socket.send(msg.msgToJson());
        }
        socket.onmessage=(e)=>{
            const message=JSON.parse(e.data);
            switch(message.type){
                case "A" : alramMessage(message);break;
                case "M" : msgPrint(message);break;
            }
        }
        $("#send-btn").click(e=>{
            const message=$("#msg").val();
            sendMessage(message);
            document.getElementById("msg").value = "";
        });
        const alramMessage=(message)=>{
            const $h3=$("<h3>").text(message.data).css("textAlign","center");
            $("#msg-container").append($h3);
        }
        const msgPrint=(message)=>{
        	const isSelf = sender === message.sender;
        	  const $wrapper = $("<div>").addClass("chat-message").addClass(isSelf ? "self" : "other");
        	  const $sender = $("<div>").addClass("chat-sender").text(message.sender);
        	  const $bubble = $("<div>").addClass("chat-bubble").text(message.message);
        	  const formatSendTime = formatDateTime(message.sendTime);
        	  const $sendTime = $("<div>").addClass("chat-sender").text(formatSendTime);
        	  $wrapper.append($sender).append($bubble).append($sendTime);
        	  $("#msg-container").append($wrapper);
        	  $("#msg-container").scrollTop($("#msg-container")[0].scrollHeight);
        }


        const sendMessage=(message)=>{
        	const sendTime = new Date().toISOString();
            const msg=new Message('M',groupNumber,sender,message,sendTime);
            //메세지 전송용 함수
            socket.send(msg.msgToJson());
        }

        class Message{
            constructor(type,groupNumber,sender,message,sendTime){
            	this.type=type;
                this.groupNumber=groupNumber;
                this.sender=sender;
                this.message=message;
                this.sendTime=sendTime;
            }
            msgToJson(){
                return JSON.stringify(this);
            }
        }

        const formatDateTime = (isoString) => {
            const date = new Date(isoString);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
          return `\${year}-\${month}-\${day} \${hours}:\${minutes}`;
      	}
            
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


    </script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>