<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.niw.market.model.dto.Material" %>
<%-- <%@ page import="com.niw.common.model.vo.PageInfo" %> --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
  List<Material> materials = (List<Material>)request.getAttribute("materials");
 /*  PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo"); */
  String currentLevel = (String)request.getAttribute("currentLevel");
  if(currentLevel == null) currentLevel = "elementary";
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/market.css">

<!-- Main Content -->
<main>
  <!-- Tabs & 포인트 버튼 -->
  <div class="tab-header">
    <div class="tab-buttons">
      <button id="elementaryBtn" class="tab-button <%=currentLevel.equals("elementary") ? "active" : ""%>" onclick="elementaryBtn()">초등학생</button>
      <button id="middleBtn" class="tab-button <%=currentLevel.equals("middle") ? "active" : ""%>" onclick="middleBtn()">중학생</button>
      <button id="highBtn" class="tab-button <%=currentLevel.equals("high") ? "active" : ""%>" onclick="highBtn()">고등학생</button>
    </div>
    <button class="points-button" onclick="location.href='<%=request.getContextPath()%>/user/points.do'">포인트 충전하기</button>
  </div>

  <!-- Search Box - 초등학교 -->
  <section id="elementaryschool" class="search-box" <%=currentLevel.equals("elementary") ? "" : "style='display: none;'"%>>
    <div class="search-header">
      <div class="search-title">학년/과목/검색</div>
      <div class="search-controls">
        <button class="search-reset">초기화</button>
        <div class="search-result-count">검색결과 총 <span><%=materials != null ? materials.size() : 0%></span> 건</div>
      </div>
    </div>

    <form action="<%=request.getContextPath()%>/materials/search.do" method="get">
      <input type="hidden" name="level" value="elementary">
      
      <!-- 학년 -->
      <div class="form-group">
        <div class="form-label">학년</div>
        <div class="form-option-group">
          <label class="form-option active">
            <input type="radio" name="grade" value="1-2" checked>
            <span>초등 1~2</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="3">
            <span>초등 3</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="4">
            <span>초등 4</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="5">
            <span>초등 5</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="6">
            <span>초등 6</span>
          </label>
        </div>
      </div>

      <!-- 과목 -->
      <div class="form-group">
        <div class="form-label">과목</div>
        <div class="form-option-group">
          <label class="form-option">
            <input type="checkbox" name="subject" value="korean">
            <span>국어</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="math">
            <span>수학</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="english">
            <span>영어</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="social">
            <span>사회</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="ethics">
            <span>윤리</span>
          </label>
        </div>
      </div>

      <!-- 검색 -->
      <div class="form-group">
        <div class="form-label">검색</div>
        <div class="search-field">
          <input type="text" name="keyword" class="search-input-field" placeholder="주제를 입력해주세요.">
          <button type="submit" class="search-submit">
            <i class="bi bi-search"></i>
          </button>
        </div>
      </div>
    </form>
  </section>

  <!-- Search Box - 중학교 -->
  <section id="middleschool" class="search-box" <%=currentLevel.equals("middle") ? "" : "style='display: none;'"%>>
    <div class="search-header">
      <div class="search-title">학년/과목/검색</div>
      <div class="search-controls">
        <button class="search-reset">초기화</button>
        <div class="search-result-count">검색결과 총 <span><%=materials != null ? materials.size() : 0%></span> 건</div>
      </div>
    </div>

    <form action="<%=request.getContextPath()%>/materials/search.do" method="get">
      <input type="hidden" name="level" value="middle">
      
      <!-- 학년 -->
      <div class="form-group">
        <div class="form-label">학년</div>
        <div class="form-option-group">
          <label class="form-option active">
            <input type="radio" name="grade" value="1" checked>
            <span>중등 1</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="2">
            <span>중등 2</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="3">
            <span>중등 3</span>
          </label>
        </div>
      </div>

      <!-- 과목 -->
      <div class="form-group">
        <div class="form-label">과목</div>
        <div class="form-option-group">
          <label class="form-option">
            <input type="checkbox" name="subject" value="korean">
            <span>국어</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="math">
            <span>수학</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="english">
            <span>영어</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="social">
            <span>사회</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="science">
            <span>과학</span>
          </label>
        </div>
      </div>

      <!-- 검색 -->
      <div class="form-group">
        <div class="form-label">검색</div>
        <div class="search-field">
          <input type="text" name="keyword" class="search-input-field" placeholder="주제를 입력해주세요.">
          <button type="submit" class="search-submit">
            <i class="bi bi-search"></i>
          </button>
        </div>
      </div>
    </form>
  </section>

  <!-- Search Box - 고등학교 -->
  <section id="highschool" class="search-box" <%=currentLevel.equals("high") ? "" : "style='display: none;'"%>>
    <div class="search-header">
      <div class="search-title">학년/과목/검색</div>
      <div class="search-controls">
        <button class="search-reset">초기화</button>
        <div class="search-result-count">검색결과 총 <span><%=materials != null ? materials.size() : 0%></span> 건</div>
      </div>
    </div>

    <form action="<%=request.getContextPath()%>/materials/search.do" method="get">
      <input type="hidden" name="level" value="high">
      
      <!-- 학년 -->
      <div class="form-group">
        <div class="form-label">학년</div>
        <div class="form-option-group">
          <label class="form-option active">
            <input type="radio" name="grade" value="1" checked>
            <span>고등 1</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="2">
            <span>고등 2</span>
          </label>
          <label class="form-option">
            <input type="radio" name="grade" value="3">
            <span>고등 3</span>
          </label>
        </div>
      </div>

      <!-- 과목 -->
      <div class="form-group">
        <div class="form-label">과목</div>
        <div class="form-option-group">
          <label class="form-option">
            <input type="checkbox" name="subject" value="korean">
            <span>국어</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="math">
            <span>수학</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="english">
            <span>영어</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="social">
            <span>사회</span>
          </label>
          <label class="form-option">
            <input type="checkbox" name="subject" value="science">
            <span>과학</span>
          </label>
        </div>
      </div>

      <!-- 검색 -->
      <div class="form-group">
        <div class="form-label">검색</div>
        <div class="search-field">
          <input type="text" name="keyword" class="search-input-field" placeholder="주제를 입력해주세요.">
          <button type="submit" class="search-submit">
            <i class="bi bi-search"></i>
          </button>
        </div>
      </div>
    </form>
  </section>

  <!-- Breadcrumb -->
  <div class="breadcrumb">
    <a href="<%=request.getContextPath()%>/">홈</a>
    <span class="breadcrumb-separator">></span>
    <a href="<%=request.getContextPath()%>/materials/list.do">학습자료</a>
    <span class="breadcrumb-separator">></span>
    <span class="breadcrumb-active">
      <%if("elementary".equals(currentLevel)) {%>초등학교<%}
        else if("middle".equals(currentLevel)) {%>중학교<%}
        else if("high".equals(currentLevel)) {%>고등학교<%}%>
    </span>
  </div>

  <!-- Product Grid -->
  <div id="product-list" class="product-grid">
    <%if(materials != null && !materials.isEmpty()) {%>
      <%for(Material material : materials) {%>
        <div class="product-card">
          <div class="product-image">
            <%if(material.thumbnailFilePaths() != null && !material.thumbnailFilePaths().isEmpty()) {%>
              <img src="<%=request.getContextPath()%>/resources/images/materials/<%=material.thumbnailFilePaths()%>" alt="<%=material.materialTitle()%> 미리보기">
            <%} else {%>
              <img src="<%=request.getContextPath()%>/resources/images/no-image.png" alt="이미지 없음">
            <%}%>
          </div>
          <div class="product-content">
            <h3 class="product-title">
              <a href="<%=request.getContextPath()%>/materials/detail.do?no=<%=material.materialId()%>"><%=material.materialTitle()%></a>
              <span class="product-instructor">(<%=material.instructorName()%>)</span>
            </h3>
            <div class="product-price"><%=String.format("%,d", material.materialPrice())%>원</div>
            <div class="product-actions">
              <button class="cart-button" onclick="addToCart(<%=material.materialId()%>)">장바구니</button>
              <button class="buy-button" onclick="buyNow(<%=material.materialId()%>)">구매하기</button>
            </div>
          </div>
        </div>
      <%}%>
    <%} else {%>
      <div class="no-results">
        <p>검색 결과가 없습니다.</p>
      </div>
    <%}%>
  </div>


  
  
</main>
	
	
<script>
  // Tab switching functionality
  const elementaryBtn = () => {
    $("#elementaryschool").show();
    $("#middleschool, #highschool").hide();
    
    $("#elementaryBtn, #middleBtn, #highBtn").removeClass("active");
    $("#elementaryBtn").addClass("active");
    
    // URL 변경
    window.history.pushState({}, '', '<%=request.getContextPath()%>/materials/list.do?level=elementary');
  };

  const middleBtn = () => {
    $("#middleschool").show();
    $("#elementaryschool, #highschool").hide();
    
    $("#elementaryBtn, #middleBtn, #highBtn").removeClass("active");
    $("#middleBtn").addClass("active");
    
   
    // URL 변경
    window.history.pushState({}, '', '<%=request.getContextPath()%>/materials/list.do?level=middle');
  };

  const highBtn = () => {
    $("#highschool").show();
    $("#elementaryschool, #middleschool").hide();
    
    $("#elementaryBtn, #middleBtn, #highBtn").removeClass("active");
    $("#highBtn").addClass("active");
    
    
    // URL 변경
    window.history.pushState({}, '', '<%=request.getContextPath()%>/materials/list.do?level=high');
  };

  
  // Form option selection
  $(document).on('click', '.form-option', function() {
    const input = $(this).find('input[type="radio"], input[type="checkbox"]');
    
    if (input.attr('type') === 'radio') {
      $(this).siblings().removeClass('active');
      $(this).addClass('active');
      input.prop('checked', true);
    } else if (input.attr('type') === 'checkbox') {
      $(this).toggleClass('active');
      input.prop('checked', $(this).hasClass('active'));
    }
  });

  
  // Reset button functionality
  $(document).on('click', '.search-reset', function() {
    const form = $(this).closest('.search-box').find('form');
    form[0].reset();
    form.find('.form-option').removeClass('active');
    form.find('.form-option:first-child').addClass('active');
  });

  // Shopping cart functionality
  function addToCart(materialNo) {
    <%if(loginUser != null) {%>
      $.ajax({
        url: '<%=request.getContextPath()%>/cart/add.do',
        type: 'POST',
        data: { materialNo: materialNo },
        success: function(response) {
          if(response.success) {
            alert('장바구니에 추가되었습니다.');
          } else {
            alert('장바구니 추가에 실패했습니다.');
          }
        },
        error: function() {
          alert('오류가 발생했습니다.');
        }
      });
    <%} else {%>
      alert('로그인이 필요합니다.');
      location.href = '<%=request.getContextPath()%>/user/loginview.do';
    <%}%>
  }

  // Buy now functionality
  function buyNow(materialNo) {
    <%if(loginUser != null) {%>
      location.href = '<%=request.getContextPath()%>/purchase/direct.do?materialNo=' + materialNo;
    <%} else {%>
      alert('로그인이 필요합니다.');
      location.href = '<%=request.getContextPath()%>/user/loginview.do';
    <%}%>
  }

  // 페이지 로드 시 현재 레벨에 맞는 탭 활성화
  $(document).ready(function() {
    const currentLevel = '<%=currentLevel%>';
    if(currentLevel === 'middle') {
      middleBtn();
    } else if(currentLevel === 'high') {
      highBtn();
    } else {
      elementaryBtn();
    }
  });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>