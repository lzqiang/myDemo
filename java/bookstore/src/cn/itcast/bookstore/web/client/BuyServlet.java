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
		 * 1.��ȡҪɾ�����id
		 * 2.�õ����ﳵ
		 * 3.ɾ��������
		 * 4.����listcartҳ��
		 */
		String bookid=request.getParameter("bookid");
		Cart cart=(Cart) request.getSession().getAttribute("shopcart");
		cart.getMap().remove(bookid);
		request.getRequestDispatcher("/client/listcart.jsp").forward(request, response);
		
	}
	//���ɶ���
	private void getnorder(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
		//�ж��û��Ƿ��¼
			HttpSession session=request.getSession();
			User user=(User) session.getAttribute("user");
			if(user==null){
				request.setAttribute("message","��ѡ��½");
				request.getRequestDispatcher("/message.jsp").forward(request, response);
				return ;
			}
			//2.����һ�������������ţ��µ����ڣ��ܽ�˭�� ����״̬ 0δ���� 1�ѷ��������������
			//3.���ɶ������������ ������Ʒ�ĵļ۸� �����
			//��ȡ���ﳵ
			Cart cart=(Cart) request.getSession().getAttribute("shopcart");
			Orders orders=new Orders();
			orders.setId(UUIdUtil.getIdgener());
			orders.setDate(new Date());
			orders.setState(0);
			orders.setTotalmoney(cart.getTotalmoney());
			orders.setUser(user);
			//���ɶ�����
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
			request.setAttribute("message","���ã�ϵͳ���ڴ���������� ��ȴ�.....");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","���ɶ���ʧ��");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
		
	}
	private void buy(HttpServletRequest request, HttpServletResponse response) {
		try{
		
		//��ȡ�������
		String id=request.getParameter("bookid");
		Books book=bookservice.findById(id);
		//��ȡ���ﳵ
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
			request.setAttribute("messag","��ȡ���ﳵʧ��");
			request.getRequestDispatcher("/message.jsp");
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
