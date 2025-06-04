package com.niw.market.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.market.model.dto.Material;
import com.niw.market.model.dto.Purchase;
import com.niw.market.model.service.MaterialService;
import com.niw.market.model.service.PurchaseService;
import com.niw.user.model.dto.User;

@WebServlet("/market/purchase.do")
public class PurchaseMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        
        try {
        
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("loginUser");
            
            if (loginUser == null) {
                out.print("{\"success\": false, \"message\": \"로그인이 필요합니다.\"}");
                return;
            }
            
           
            String materialIdStr = request.getParameter("materialId");
            if (materialIdStr == null || materialIdStr.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"잘못된 요청입니다.\"}");
                return;
            }
            
            int materialId;
            try {
                materialId = Integer.parseInt(materialIdStr);
            } catch (NumberFormatException e) {
                out.print("{\"success\": false, \"message\": \"잘못된 자료 ID입니다.\"}");
                return;
            }
            
            String userId = loginUser.userId();
            
         
            PurchaseService purchaseService = PurchaseService.SERVICE;
            if (purchaseService.isPurchased(userId, materialId)) {
                out.print("{\"success\": false, \"message\": \"이미 구매한 자료입니다.\"}");
                return;
            }
            
        
            MaterialService materialService = MaterialService.SERVICE;
            Material material = materialService.getMaterialById(materialId);
            
            if (material == null) {
                out.print("{\"success\": false, \"message\": \"존재하지 않는 자료입니다.\"}");
                return;
            }
            
            if (!"ACTIVE".equals(material.materialStatus())) {
                out.print("{\"success\": false, \"message\": \"구매할 수 없는 자료입니다.\"}");
                return;
            }
            

            Purchase purchase = Purchase.builder()
                    .userId(userId)
                    .materialId(materialId)
                    .purchasePrice(material.materialPrice())
                    .purchaseStatus("COMPLETED")
                    .build();
            
            int result = purchaseService.registerPurchase(purchase);
            
            if (result > 0) {
                out.print("{\"success\": true, \"message\": \"구매가 완료되었습니다.\", \"materialTitle\": \"" 
                        + material.materialTitle() + "\", \"price\": " + material.materialPrice() + "}");
            } else {
                out.print("{\"success\": false, \"message\": \"구매 처리 중 오류가 발생했습니다.\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"서버 오류가 발생했습니다.\"}");
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        response.getWriter().print("{\"success\": false, \"message\": \"허용되지 않는 요청 방식입니다.\"}");
    }
}