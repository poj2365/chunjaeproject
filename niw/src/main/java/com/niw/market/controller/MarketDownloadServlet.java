package com.niw.market.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.market.model.dto.Material;
import com.niw.market.model.service.MaterialService;

/**
 * Servlet implementation class MarketDownloadServlet
 */
@WebServlet("/market/download.do")
public class MarketDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarketDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int materialID = Integer.parseInt(request.getParameter("id"));
		Material material = MaterialService.SERVICE.getMaterialById(materialID);
		String filePath = "/"+material.materialFilePath();
		String realPath = request.getServletContext().getRealPath(filePath);
		String fileName = material.savedFileName();
		
		
		File file = new File(realPath);
		try(FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			BufferedOutputStream os = new BufferedOutputStream(response.getOutputStream())) {
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			
			
			byte[] buffer = new byte[1024];
			int bytesRead=-1;
			while ((bytesRead = bis.read(buffer)) != -1) {
				os.write(buffer, 0, bytesRead);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
