package com.niw.market.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.market.model.dto.Material;
import com.niw.market.model.service.MaterialService;

@WebServlet("/main/materials.do")
public class MainMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
      
        MaterialService service = MaterialService.SERVICE;
        List<Material> recentMaterials = service.getRecentMaterials(3);
        
     
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
     
        Gson gson = new Gson();
        String jsonData = gson.toJson(recentMaterials);
        
        out.print(jsonData);
        out.flush();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}