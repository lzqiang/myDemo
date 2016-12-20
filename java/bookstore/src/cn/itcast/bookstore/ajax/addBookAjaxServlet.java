package cn.itcast.bookstore.ajax;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import cn.itcast.bookstore.domain.BookFormBean;
import cn.itcast.bookstore.utils.FillBookFormBean;
public class addBookAjaxServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		BookFormBean formbean=FillBookFormBean.toFormBookBean(request, BookFormBean.class);
		if(!formbean.valiate()){
			Map<String,String> map=formbean.getErrors();
			JSONArray array=JSONArray.fromObject(map);
			response.getWriter().println(array.toString());
			
		}
	}

}
