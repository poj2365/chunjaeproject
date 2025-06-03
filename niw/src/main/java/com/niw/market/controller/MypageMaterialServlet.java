package com.niw.market.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.market.model.dao.PurchasedMaterialDao.PurchaseStats;
import com.niw.market.model.dto.PurchasedMaterial;
import com.niw.market.model.service.PurchasedMaterialService;
import com.niw.user.model.dto.User;

@WebServlet("/user/mypage/materials.do")
public class MypageMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 6; // 한 페이지당 6개씩
    private static final int PAGE_BAR_SIZE = 5; // 페이지바에 5개씩

    public MypageMaterialServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 로그인 체크
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            // AJAX 요청인 경우 JSON 응답
            String ajaxRequest = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(ajaxRequest)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"error\": \"login_required\"}");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/user/loginview.do");
            return;
        }
        
        // 페이지 파라미터 처리
        String cPageStr = request.getParameter("cPage");
        int cPage = 1;
        if (cPageStr != null) {
            try {
                cPage = Integer.parseInt(cPageStr);
            } catch (NumberFormatException e) {
                cPage = 1;
            }
        }
        
        // Service를 통해 데이터 조회
        PurchasedMaterialService service = PurchasedMaterialService.SERVICE;
        
        // 구매한 자료 목록 조회
        List<PurchasedMaterial> materials = service.getPurchasedMaterialList(loginUser.userId(), cPage, PAGE_SIZE);
        
        // 총 개수 조회
        int totalCount = service.getPurchasedMaterialCount(loginUser.userId());
        
        // 총 페이지 수 계산
        int totalPage = service.getTotalPage(totalCount, PAGE_SIZE);
        
        // 통계 정보 조회
        PurchaseStats stats = service.getPurchaseStats(loginUser.userId());
        
        // 페이지바 생성
        String pageBar = generatePageBar(request, cPage, totalPage, service);
        
        // request에 데이터 설정
        request.setAttribute("materials", materials);
        request.setAttribute("pageBar", pageBar);
        request.setAttribute("totalCount", stats.totalCount());
        request.setAttribute("totalAmount", stats.totalAmount());
        request.setAttribute("totalDownloads", stats.totalDownloads());
        request.setAttribute("totalReviews", stats.totalReviews());
        request.setAttribute("currentPage", cPage);
        request.setAttribute("totalPage", totalPage);
        
        // JSP로 포워딩
        request.getRequestDispatcher("/WEB-INF/views/user/mypage/mymaterial.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private String generatePageBar(HttpServletRequest request, int cPage, int totalPage, PurchasedMaterialService service) {
        if (totalPage == 0) {
            return ""; // 데이터가 없으면 페이지바도 없음
        }
        
        int pageNo = service.getStartPage(cPage, PAGE_BAR_SIZE);
        int pageEnd = service.getEndPage(cPage, PAGE_BAR_SIZE, totalPage);

        StringBuffer pageBar = new StringBuffer("<ul class='pagination justify-content-center'>");

        // 이전 버튼
        if (cPage == 1) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> prev </a>");
            pageBar.append("</li>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link material-page-link' href='#' data-page='" + (pageNo > 1 ? pageNo - 1 : 1) + "'> prev </a>");
            pageBar.append("</li>");
        }

        // 페이지 번호들
        for (int i = pageNo; i <= pageEnd; i++) {
            if (i == cPage) {
                pageBar.append("<li class='page-item active'>");
                pageBar.append("<a class='page-link' href='#'>" + i + "</a>");
            } else {
                pageBar.append("<li class='page-item'>");
                pageBar.append("<a class='page-link material-page-link' href='#' data-page='" + i + "'> " + i + " </a>");
            }
            pageBar.append("</li>");
        }

        // 다음 버튼
        if (cPage == totalPage) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> next </a>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link material-page-link' href='#' data-page='" + (pageEnd < totalPage ? pageEnd + 1 : totalPage) + "'> next </a>");
        }
        pageBar.append("</li>");
        pageBar.append("</ul>");

        return pageBar.toString();
    }
}