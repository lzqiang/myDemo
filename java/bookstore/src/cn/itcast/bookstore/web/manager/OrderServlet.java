package cn.itcast.bookstore.web.manager;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.bookstore.domain.Orders;
import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.service.OrdersService;
import cn.itcast.bookstore.service.impl.OrdersServiceImpl;

public class OrderServlet extends HttpServlet {
	private OrdersService service=new OrdersServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation=request.getParameter("operation");
		if(operation.equals("listAllNo")){
			listAllNo(request,response);
		}else if(operation.equals("listAllYes")){
			listAllyes(request,response);
		}else if(operation.equals("send")){
			send(request,response);
		}
	}

	
	private void send(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
		String orderId=request.getParameter("orderid");
		Orders orders=service.queryById(orderId);		
		service.update(orders);
		request.setAttribute("message","�������޸�Ϊ����״̬ �뼰ʱ����������");
		request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","����ʧ�� ���·���");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}


	private void listAllyes(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			List<Orders> orders=service.queryByState(1);
			for(Orders order:orders){
				User user=service.findByOrderId(order.getId());
				order.setUser(user);
			}
			request.setAttribute("orders",orders);
			request.getRequestDispatcher("/manager/listOrders1.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","��ʾʧ��");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}


	private void listAllNo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			List<Orders> orders=service.queryByState(0);
			for(Orders order:orders){
				User user=service.findByOrderId(order.getId());
				order.setUser(user);
			}
			request.setAttribute("orders",orders);
			request.getRequestDispatcher("/manager/listOrders1.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","��ʾʧ��");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
