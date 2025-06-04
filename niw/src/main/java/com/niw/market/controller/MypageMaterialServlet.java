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
        
     
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            
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
        
     
        String cPageStr = request.getParameter("cPage");
        int cPage = 1;
        if (cPageStr != null) {
            try {
                cPage = Integer.parseInt(cPageStr);
            } catch (NumberFormatException e) {
                cPage = 1;
            }
        }
        
  
        PurchasedMaterialService service = PurchasedMaterialService.SERVICE;
        
     
        List<PurchasedMaterial> materials = service.getPurchasedMaterialList(loginUser.userId(), cPage, PAGE_SIZE);
        
 
        int totalCount = service.getPurchasedMaterialCount(loginUser.userId());
        
 
        int totalPage = service.getTotalPage(totalCount, PAGE_SIZE);
        
     
        PurchaseStats stats = service.getPurchaseStats(loginUser.userId());
        
 
        String pageBar = generatePageBar(request, cPage, totalPage, service);
        

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
            return ""; 
        }
        
        int pageNo = service.getStartPage(cPage, PAGE_BAR_SIZE);
        int pageEnd = service.getEndPage(cPage, PAGE_BAR_SIZE, totalPage);

        StringBuffer pageBar = new StringBuffer("<ul class='pagination justify-content-center'>");


        if (cPage == 1) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> prev </a>");
            pageBar.append("</li>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link material-page-link' href='#' data-page='" + (pageNo > 1 ? pageNo - 1 : 1) + "'> prev </a>");
            pageBar.append("</li>");
        }


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