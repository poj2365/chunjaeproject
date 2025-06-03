package com.niw.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;

import com.niw.board.model.dto.Notice;
import com.niw.board.service.BoardService;
import com.niw.common.CommonTemplate;

@WebServlet("/board/saveNotice.do")
public class SaveNoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SaveNoticeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String rawContent = request.getParameter("content");
		String content = Jsoup.clean(rawContent, Safelist.relaxed()
			    .addTags(
			        "img", "h1", "h2", "h3", "h4", "h5", "h6",
			        "figure", "figcaption", "picture", "source",
			        "iframe", "table", "tbody", "thead", "tfoot", "tr", "td", "th", "colgroup", "col",
			        "blockquote", "p", "ul", "ol", "li", "a", "br", "hr", "span", "div",
			        "strong", "em", "u", "del", "code", "pre", "oembed"
			    )
			    .addAttributes("img", "src", "width", "height", "alt", "data-ckbox-resource-id", "srcset", "sizes")
			    .addAttributes("a", "href", "target", "rel", "download", "data-ckbox-resource-id")
			    .addAttributes("iframe", "src", "width", "height", "frameborder", "allow", "allowfullscreen", "loading")
			    .addAttributes("source", "srcset", "type", "sizes")
			    .addAttributes("figure", "class", "style")
			    .addAttributes("table", "class", "style")
			    .addAttributes("td", "colspan", "rowspan", "style")
			    .addAttributes("th", "colspan", "rowspan", "style")
			    .addAttributes("span", "style")
			    .addAttributes("div", "style")
			    .addAttributes("blockquote", "class", "style")
			    .addAttributes("p", "class", "style")
			    .addAttributes("oembed", "url")
			); 
		BoardService.SERVICE.saveNotice(Notice.builder()
											  .noticeTitle(title)
											  .noticeContent(content)
											  .build());
		response.sendRedirect(request.getContextPath() + "/admin/adminpage.do");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
