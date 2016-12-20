package cn.itcast.bookstore.web.manager;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.service.CategoryService;
import cn.itcast.bookstore.service.impl.CategoryServiceImpl;

public class categoryServlet extends HttpServlet {
	private CategoryService service=new CategoryServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation=request.getParameter("operation");
		if(operation.equals("addCategory")){
			addCategory(request,response);
		}else if(operation.equals("showCategory")){
			showCategory(request,response);
		}else if(operation.equals("delete")){
			delete(request,response);
		}else if(operation.equals("update")){
			update(request,response);
		}else if(operation.equals("updateSave")){
			updateSave(request,response);
		}
	}
	private void updateSave(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String id=request.getParameter("id");
			String name=request.getParameter("categoryName");
			String description=request.getParameter("description");
			Category category=new Category();
			category.setId(id);
			category.setName(name);
			category.setDescription(description);
			service.update(category);
			request.setAttribute("message","修改成功");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","修改失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}
	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			String id=request.getParameter("id");
			Category category=service.findById(id);
			//转向修改页面
			request.setAttribute("category",category);
			request.getRequestDispatcher("/manager/updateCategory.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","跳转失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}
	}
	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			String id=request.getParameter("id");
			service.del(id);
			request.setAttribute("message","删除成功");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","删除失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}
	private void showCategory(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
		List<Category> list=service.findAll();
		request.setAttribute("category",list);
		request.getRequestDispatcher("/manager/showCategory.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","显示失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}
	}
	private void addCategory(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String name=request.getParameter("categoryName");
			String description=request.getParameter("description");
			Category category=new Category();
			category.setName(name);
			category.setDescription(description);
			service.add(category);
			request.setAttribute("message","添加成功");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","添加失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
