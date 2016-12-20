package cn.itcast.bookstore.web.client;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.Cart;
import cn.itcast.bookstore.domain.CartItem;
import cn.itcast.bookstore.domain.OrderItem;
import cn.itcast.bookstore.domain.Orders;
import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.service.BookService;
import cn.itcast.bookstore.service.OrdersService;
import cn.itcast.bookstore.service.impl.BooksServiceImpl;
import cn.itcast.bookstore.service.impl.OrdersServiceImpl;
import cn.itcast.bookstore.utils.UUIdUtil;

public class BuyServlet extends HttpServlet {
	private BookService bookservice=new BooksServiceImpl();
	private OrdersService orderservice=new OrdersServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation=request.getParameter("operation");
		if(operation.equals("buy")){
			buy(request,response);
		}else if(operation.equals("genorder")){
			getnorder(request,response);
		}else if(operation.equals("deleteCartBook")){
			deletecart(request,response);
		}else if(operation.equals("clear")){
			clear(request,response);
		}
	}
	private void clear(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cart cart=(Cart) request.getSession().getAttribute("shopcart");
		cart.getMap().clear();
		request.getRequestDispatcher("/client/listcart.jsp").forward(request, response);
	}
	private void deletecart(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 1.获取要删除书的id
		 * 2.得到购物车
		 * 3.删除购物项
		 * 4.返回listcart页码
		 */
		String bookid=request.getParameter("bookid");
		Cart cart=(Cart) request.getSession().getAttribute("shopcart");
		cart.getMap().remove(bookid);
		request.getRequestDispatcher("/client/listcart.jsp").forward(request, response);
		
	}
	//生成订单
	private void getnorder(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
		//判断用户是否登录
			HttpSession session=request.getSession();
			User user=(User) session.getAttribute("user");
			if(user==null){
				request.setAttribute("message","请选登陆");
				request.getRequestDispatcher("/message.jsp").forward(request, response);
				return ;
			}
			//2.生成一个订单，订单号，下单日期，总金额，谁的 订单状态 0未发货 1已发货，多个订单项
			//3.生成订单项，购买数量 单个商品的的价格 书对象
			//获取购物车
			Cart cart=(Cart) request.getSession().getAttribute("shopcart");
			Orders orders=new Orders();
			orders.setId(UUIdUtil.getIdgener());
			orders.setDate(new Date());
			orders.setState(0);
			orders.setTotalmoney(cart.getTotalmoney());
			orders.setUser(user);
			//生成订单项
			Map<String,CartItem> map=cart.getMap();			
			for(Map.Entry<String,CartItem> me:map.entrySet()){
				OrderItem orderItem=new OrderItem();
				orderItem.setId(UUIdUtil.getIdgener());
				orderItem.setBook(me.getValue().getBook());
				orderItem.setNum(me.getValue().getNum());
				orderItem.setTotalprice(me.getValue().getPrice());
				orders.getOrderItem().add(orderItem);
			}
			
			orderservice.add(orders);
			request.setAttribute("message","您好，系统正在处理你的请求 请等待.....");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","生成订单失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
		
	}
	private void buy(HttpServletRequest request, HttpServletResponse response) {
		try{
		
		//获取购买的书
		String id=request.getParameter("bookid");
		Books book=bookservice.findById(id);
		//获取购物车
		Cart cart=(Cart) request.getSession().getAttribute("shopcart");
		if(cart==null){
			cart=new Cart();
			cart.addBook(book);
			request.getSession().setAttribute("shopcart",cart);
		}else{
			cart.addBook(book);
		}
		request.getRequestDispatcher("/client/listcart.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("messag","获取购物车失败");
			request.getRequestDispatcher("/message.jsp");
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
