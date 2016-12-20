package cn.itcast.bookstore.web.client;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.OrderItem;
import cn.itcast.bookstore.domain.Orders;
import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.service.BookService;
import cn.itcast.bookstore.service.OrdersService;
import cn.itcast.bookstore.service.impl.BooksServiceImpl;
import cn.itcast.bookstore.service.impl.OrdersServiceImpl;

public class showOrderServlet extends HttpServlet {
	private OrdersService service=new OrdersServiceImpl();
	private BookService bookservice=new BooksServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation=request.getParameter("operation");
		if(operation.equals("showOrder")){
			showOrder(request,response);
		}else if(operation.equals("UserOrderDetail")){
			UserOrderDetail(request,response);
		}
	}
	//获取详细订单信息  就是获取订单项
	private void UserOrderDetail(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String order_id=request.getParameter("order_id");
			List<OrderItem> orderItems=service.queryItem(order_id);
			for(OrderItem item:orderItems){
				Books book=service.findByItemId(item.getId());
				item.setBook(book);
			}
			request.setAttribute("items",orderItems);
			request.getRequestDispatcher("/client/UserOrderDetail.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","获取详细信息失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}
	//获取订单信息
	private void showOrder(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//根据用户的id查询
		try{
			HttpSession session=request.getSession();
			User user=(User) session.getAttribute("user");
			if(user==null){
				request.setAttribute("message","请先登录");
				request.getRequestDispatcher("/message.jsp").forward(request, response);
				return ;
			}
			List<Orders> list=service.query(user.getId());
			request.setAttribute("list",list);
			request.getRequestDispatcher("/client/showOrders.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("list","查看订单失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}

}
