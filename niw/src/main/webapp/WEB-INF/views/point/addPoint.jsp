<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery넣어주기 -->
 <!-- <script src="https://cdn.portone.io/v2/browser-sdk.js"></script> -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!--  <script>
  document.addEventListener("DOMContentLoaded", function () {
    IMP.init("iamporttest"); // ⚠️ 여기에 본인 MID 넣기 (테스트용: iamporttest_3)
  });
</script> -->
<meta charset="UTF-8">
  <title>포인트 충전</title>
  <style>
    body {
      background-color: #f7f9fc;
      font-family: 'Noto Sans KR', sans-serif;
      padding: 40px 20px;
    }
    .charge-container {
      max-width: 500px;
      margin: 0 auto;
      background: #fff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }
    h2 {
      text-align: center;
      margin-bottom: 30px;
    }
    .point-display {
      font-size: 18px;
      margin-bottom: 20px;
      background: #eaf4ff;
      padding: 15px;
      border-radius: 8px;
      text-align: center;
    }
    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }
    input[type="text"] {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      margin-bottom: 10px;
      border-radius: 8px;
      border: 1px solid #ccc;
    }
    .calculated-info {
      text-align: center;
      font-size: 15px;
      margin-bottom: 15px;
      color: #333;
      background-color: #f1f1f1;
      padding: 10px;
      border-radius: 6px;
    }
    .amount-buttons {
    display: flex;
    flex-direction: column; 
    gap: 10px;
    margin-bottom: 20px;
    }
    .amount-buttons button {
    width: 100%;
    padding: 12px;
    background-color: #ddd;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    font-size: 14px;
    }
    .amount-buttons button:hover {
      background-color: #c9c1c1;
    }
    .charge-btn {
      width: 100%;
      padding: 14px;
      background-color: #24b1b5;
      border: none;
      color: white;
      font-size: 16px;
      font-weight: bold;
      border-radius: 8px;
      cursor: pointer;
    }
    .charge-btn:hover {
      background-color: #1a8588;
    }
    .notice {
      margin-top: 15px;
      font-size: 13px;
      color: #777;
      text-align: center;
    }
  </style>
</head>
<body>

<div class="charge-container">
  <h2>포인트 충전</h2>

  <div class="point-display">
    현재 보유 포인트: <strong>2500P</strong>
  </div>

  
    <label for="amount">충전할 포인트 (P)</label>
    <input type="text" readonly id="amount" name="amount" oninput="updatePaymentInfo()">

    <div class="calculated-info" id="paymentInfo">
      결제할 금액: 0원
    </div>


   <div class="amount-buttons">
    
    <button type="button" onclick="setAmount(10000)">10000P (11,000원)</button>
    <button type="button" onclick="setAmount(20000)">20000P (22,000원)</button>
    <button type="button" onclick="setAmount(30000)">30000P (33,000원)</button>
    <button type="button" onclick="setAmount(40000)">40000P (44,000원)</button>
    <button type="button" onclick="setAmount(50000)">50000P (55,000원)</button>
</div>

    <button type="button" class="charge-btn" onclick ="requestPay();">충전하기</button>

  <div class="notice">
    충전 금액은 포인트의 10%가 추가된 금액입니다.<br>
    예: 10,000P → 11,000원 결제
  </div>
</div>

<script>

 
  function requestPay() {
    const amount = parseInt(document.getElementById('amount').value);
    if (isNaN(amount)) {
       alert("충전할 포인트를 선택해주세요.");
      return; 
    }

    const payAmount = Math.floor(amount * 1.1);

    const userCode = "imp38113060";
    IMP.init(userCode); 
    
    IMP.request_pay(
      {
        channelKey: "channel-key-0444714e-72d4-48cc-a56d-8cf57cdd64db", // 내가 발급한 채널키
        merchant_uid: Math.floor(Math.random()*1000000000),
        name: "포인트 : " + amount + "P" , // 출력할 상품정보 이름
        pay_method: "card", 
        escrow: false,
        amount: amount*1.1,
        tax_free: 3000,
        buyer_name: "홍길동",
        buyer_email: "buyer@example.com",
        buyer_tel: "02-1670-5176",
        buyer_addr: "성수이로 20길 16",
        buyer_postcode: "04783",
        currency: "KRW",
        locale: "ko",
        display: { card_quota: [0, 6] },
        appCard: false,
        useCardPoint: false,
        bypass: {
          tosspayments: {
            useInternationalCardOnly: false, // 영어 결제창 활성화
          },
        },
      },
      async (response) => {
    	 console.log(response);
    	 if(response.error_code != null){
    		  return alert("결제가 정상적으로 처리되지 않았습니다.");
    	 }
    	 //서버요청 저장하기 로직 구현
    	 /* const endpointResponse=await fetch(""); */
    	 sendToServer(response);
    	 
      },
    );
  } 
 
  function sendToServer(response) {
	  
    fetch("<%=request.getContextPath()%>/point/verifyPayment", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ imp_uid: response.imp_uid ,
    	  merchant_uid: response.merchant_uid
      	}) 
      })
      .then(response=>response.json())
      .then(data=>{
    	  if(data.result=="success"){
    		  alert(data.message);
    		  window.close();
    	  }else{
    		  alert(data.message);
    	  }
      })
    }

  function setAmount(value) {
  	document.getElementById('amount').value = value;
    updatePaymentInfo(); 
  }
  
 

  function updatePaymentInfo() {
    const amount = parseInt(document.getElementById('amount').value);
    
    const display = document.getElementById('paymentInfo');

    if (!isNaN(amount)) {
      const realPrice = Math.floor(amount * 1.1);
      console.log("실제결제금액",realPrice);
      display.textContent = "실제결제금액 : " + realPrice.toLocaleString() + "원";
      
    } else {
      
    }
  }
  
  
  const display = document.getElementById('paymentInfo');
  display.textContent = '결제할 금액: 0원';
</script>



</body>
</html>