package cn.itcast.bookstore.web.client;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.domain.Page;
import cn.itcast.bookstore.service.BookService;
import cn.itcast.bookstore.service.CategoryService;
import cn.itcast.bookstore.service.impl.BooksServiceImpl;
import cn.itcast.bookstore.service.impl.CategoryServiceImpl;

public class WelcomeServlet extends HttpServlet {
	private CategoryService categoryservice=new CategoryServiceImpl();
	private BookService bookservice=new BooksServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pageNum=request.getParameter("pageNum");
		String category_id=request.getParameter("category_id");
		
		if(category_id==null || category_id.trim().equals("")){
			List<Category> categorys=categoryservice.findAll();
			Page page=bookservice.getPagRecords(pageNum);
			
			request.setAttribute("categorys",categorys);
			request.setAttribute("page",page);
		}else{
			List<Category> categorys=categoryservice.findAll();
			Page page=bookservice.getCategoryPageRecords(pageNum, category_id);
			request.setAttribute("categorys",categorys);
			request.setAttribute("current_category_id",category_id);
			request.setAttribute("page",page);
		}
		request.getRequestDispatcher("/client/welcome.jsp").forward(request, response);
	}

}
