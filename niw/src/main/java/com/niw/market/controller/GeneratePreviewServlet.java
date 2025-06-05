package com.niw.market.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.json.JSONArray;
import org.json.JSONObject;

import com.niw.market.model.dto.Material;
import com.niw.user.model.dto.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class GeneratePreviewServlet
 */
@WebServlet("/market/generatePreview.do")
public class GeneratePreviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GeneratePreviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");
		JSONObject result=new JSONObject();
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("loginUser");
		
		try {
			String uploadPath = getServletContext().getRealPath("/resources/upload/market/" + user.userId()+"/material");
			String previewPath=uploadPath+"/"+"previews";
			File uploadDir = new File(uploadPath);
			File previewDir = new File(previewPath);
			int fileSize=1024*1024*50;
			String encoding="UTF-8";
			DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy();
			if(!uploadDir.exists()) uploadDir.mkdirs();
			if(!previewDir.exists()) previewDir.mkdirs();
			
			MultipartRequest multipartRequest= new MultipartRequest(request,uploadPath,fileSize,encoding,dfrp);
			
			HttpSession fileSession = request.getSession();

			File uploadFile=multipartRequest.getFile("uploadFile");
			String originalFileName=multipartRequest.getOriginalFileName("uploadFile");
			String savedFileName=multipartRequest.getFilesystemName("uploadFile");
			JSONArray imageFiles= convertPdfToImages(uploadFile, previewPath,savedFileName);
			
			Material material= new Material(
					0,
					user.userId(),
					user.userName(),
					"",
					"",
					originalFileName,
					savedFileName,
					"",
					0,
					imageFiles.length(),//페이지수
					new ArrayList<String>(),
					previewPath,
					uploadPath,
					"",
					"",
					"",
					"",
					new Date(System.currentTimeMillis()),
					new Date(System.currentTimeMillis()),
					0,
					0,
					0,
					0
					);
			
					
					
			fileSession.setAttribute("material", material);

			result.put("success", true);
			result.put("pages", imageFiles);
			result.put("totalPages", imageFiles.length());
			
				
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		out.print(result.toString());
		out.flush();
		
		
	} 
	
		
	  private JSONArray convertPdfToImages(File uploadFile, String previewPath, String savedFileName) throws IOException {
	        JSONArray imageFiles = new JSONArray();
	        try (PDDocument document = Loader.loadPDF(uploadFile);) {
	            PDFRenderer pdfRenderer = new PDFRenderer(document);

	            for (int page = 0; page < document.getNumberOfPages(); page++) {
	                BufferedImage image = pdfRenderer.renderImageWithDPI(page, 150, ImageType.RGB);
	                String imageFileName = savedFileName.substring(0,savedFileName.lastIndexOf("."))+"_preview_"+ "page" + (page + 1) + ".png";
	                String imageFilePath = previewPath + File.separator + imageFileName;
	                File imageFile = new File(imageFilePath);
	                ImageIO.write(image, "PNG", imageFile);
	                
	             
	                imageFiles.put(imageFileName);
	            }
	        }
	        	
	        return imageFiles;
	    }
	}
	
	
	


