package cn.itcast.bookstore.web.client;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.bookstore.service.UserService;
import cn.itcast.bookstore.service.impl.UserServiceImpl;

public class activedServlet extends HttpServlet {
	private UserService service=new UserServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			String code=request.getParameter("code");
			System.out.println(code);
			service.active(code);
			request.setAttribute("message","您以成功激活您的账户  现在可以登录了");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","激活失败  请重新获取激活码");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}
	}

}
