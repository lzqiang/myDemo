package cn.itcast.bookstore.web.client;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.service.UserService;
import cn.itcast.bookstore.service.impl.UserServiceImpl;

public class ajaxServlet extends HttpServlet {
	private UserService service=new UserServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username=request.getParameter("username");
		User user=service.findByUsername(username);
		PrintWriter out=response.getWriter();
		if(user!=null){
			out.println("用户名已存在");
		}else{
			out.println("用户名可用");
		}
	}

}
