package com.niw.board.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.board.service.BoardService;
import com.niw.user.model.dto.User;

@WebServlet("/board/recommend.do")
public class SaveRecommendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SaveRecommendServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		Map<String, Object> recommendData = gson.fromJson(reader, Map.class);
		String userId = ((User) request.getSession().getAttribute("loginUser")).userId();
		int recType = Integer.parseInt((String) recommendData.get("recType"));
		String boardType = (String) recommendData.get("boardType");
		int targetId = Integer.parseInt((String) recommendData.get("targetId"));
		int recommendFlag = BoardService.SERVICE.searchRecommend(userId, recType, boardType, targetId);
		int recommend = 0, changeArticle = 0;
		if(recommendFlag == 0) {
			recommend = BoardService.SERVICE.saveRecommend(userId, recType, boardType, targetId);
			if(recommend == 1) {
				changeArticle = BoardService.SERVICE.increaseRecommend(recType, boardType, targetId);
			}
		} else {
			recommend = BoardService.SERVICE.deleteRecommend(userId, recType, boardType, targetId);
			if(recommend == 1) {
				changeArticle = BoardService.SERVICE.decreaseRecommend(recType, boardType, targetId);
			}
		}		
		new Gson().toJson(Map.of("recommend", recommend, "recommendFlag", recommendFlag, "changeArticle", changeArticle),response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
