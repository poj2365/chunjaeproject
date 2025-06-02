package com.niw.market.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.market.model.dto.Material;
import com.niw.market.model.service.MaterialService;
import com.niw.market.model.service.PurchaseService; // ✅ PurchaseService import 추가
import com.niw.user.model.dto.User;

@WebServlet("/market/detail.do")
public class MaterialDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/market/list.do");
            return;
        }
        
        int materialId = 0;
        try {
            materialId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/market/list.do");
            return;
        }
        
  
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        String userId = loginUser != null ? loginUser.userId() : null;
        
     
        MaterialService service = MaterialService.SERVICE;
        Material material = service.getMaterialDetail(materialId);
        
        if (material == null) {
            response.sendRedirect(request.getContextPath() + "/market/list.do");
            return;
        }
        
       
        boolean isPurchased = false;
        if (userId != null) {
            isPurchased = PurchaseService.SERVICE.isPurchased(userId, materialId);
        }
        
      
        request.setAttribute("material", material);
        request.setAttribute("isPurchased", isPurchased);
        
    
        request.getRequestDispatcher("/WEB-INF/views/market/materialdetail.jsp").forward(request, response);
    }
}