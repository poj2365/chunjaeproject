package com.niw.market.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.common.JDBCTemplate;
import com.niw.market.model.dao.MaterialDao;
import com.niw.market.model.dto.Material;
import com.niw.market.model.dto.Purchase;
import com.niw.market.model.service.MaterialService;
import com.niw.market.model.service.PurchaseService;
import com.niw.user.model.dto.User;

@WebServlet("/market/list.do")
public class MaterialListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 6; // 한 페이지당 6개씩
    private static final int PAGE_BAR_SIZE = 5; // 페이지바에 5개씩

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        

        String category = request.getParameter("category");
        String grade = request.getParameter("grade");
        String subject = request.getParameter("subject");
        String cPageStr = request.getParameter("cPage");
        

        if (category == null) category = "전체";
        if (grade == null) grade = "전체";
        if (subject == null) subject = "전체";
        
        int cPage = 1;
        if (cPageStr != null) {
            try {
                cPage = Integer.parseInt(cPageStr);
            } catch (NumberFormatException e) {
                cPage = 1;
            }
        }
        
        Connection conn = JDBCTemplate.getConnection();
        MaterialDao dao = MaterialDao.DAO;
        HttpSession session = request.getSession();
        User loginUser=(User)session.getAttribute("loginUser");
        try {
            
            int totalCount = dao.getTotalCountByFilter(conn, category, grade, subject);
            
             
            int totalPage = (int) Math.ceil((double) totalCount / PAGE_SIZE);
            if (totalPage == 0) totalPage = 1;
            
            int startRow = (cPage - 1) * PAGE_SIZE + 1;
            int endRow = cPage * PAGE_SIZE;
            
            
            List<Material> materials = dao.getMaterialListByFilter(conn, category, grade, subject, startRow, endRow);
            
          
            String pageBar = generatePageBar(request, cPage, totalPage, category, grade, subject);
            List<Integer> purchases= new ArrayList<>();
            if(loginUser!=null) {
            	for(Material m : materials) {
        
            		Purchase purchase = PurchaseService.SERVICE.getPurchaseInfo(loginUser.userId(), m.materialId());
            		if(purchase!=null) {
            		purchases.add(purchase.materialId());
            		}
            	
            	}
            }
            
            
            // request에 데이터 설정
            request.setAttribute("purchases",purchases);
            request.setAttribute("materials", materials);
            request.setAttribute("pageBar", pageBar);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("currentPage", cPage);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("selectedGrade", grade);
            request.setAttribute("selectedSubject", subject);
            
    
            request.getRequestDispatcher("/WEB-INF/views/market/marketview.jsp").forward(request, response);
            
        } finally {
            JDBCTemplate.close(conn);
        }
    }
    
    private String generatePageBar(HttpServletRequest request, int cPage, int totalPage, 
                                 String category, String grade, String subject) {
        
        int pageNo = ((cPage - 1) / PAGE_BAR_SIZE) * PAGE_BAR_SIZE + 1;
        int pageEnd = pageNo + PAGE_BAR_SIZE - 1;
        
        if (pageEnd > totalPage) {
            pageEnd = totalPage;
        }
        
        StringBuffer pageBar = new StringBuffer("<ul class='pagination justify-content-center'>");

        if (cPage == 1) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> prev </a>");
            pageBar.append("</li>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link' href='" + request.getRequestURI() 
                + "?category=" + category + "&grade=" + grade + "&subject=" + subject 
                + "&cPage=" + (pageNo > 1 ? pageNo - 1 : 1) + "'> prev </a>");
            pageBar.append("</li>");
        }
        
    
        for (int i = pageNo; i <= pageEnd; i++) {
            if (i == cPage) {
                pageBar.append("<li class='page-item active'>");
                pageBar.append("<a class='page-link' href='#'>" + i + "</a>");
            } else {
                pageBar.append("<li class='page-item'>");
                pageBar.append("<a class='page-link' href='" + request.getRequestURI() 
                    + "?category=" + category + "&grade=" + grade + "&subject=" + subject 
                    + "&cPage=" + i + "'> " + i + " </a>");
            }
            pageBar.append("</li>");
        }
       
        if (cPage == totalPage) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> next </a>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link' href='" + request.getRequestURI() 
                + "?category=" + category + "&grade=" + grade + "&subject=" + subject 
                + "&cPage=" + (pageEnd < totalPage ? pageEnd + 1 : totalPage) + "'> next </a>");
        }
        pageBar.append("</li>");
        pageBar.append("</ul>");
        
        return pageBar.toString();
    }
}