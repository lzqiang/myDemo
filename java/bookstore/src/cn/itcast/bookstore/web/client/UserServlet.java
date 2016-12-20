package cn.itcast.bookstore.web.client;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.service.UserService;
import cn.itcast.bookstore.service.impl.UserServiceImpl;
import cn.itcast.bookstore.utils.MD5;
import cn.itcast.bookstore.utils.SendMessageThread;
import cn.itcast.bookstore.utils.State;
import cn.itcast.bookstore.utils.UUIdUtil;

public class UserServlet extends HttpServlet {
	private UserService userservice=new UserServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation=request.getParameter("operation");
		if(operation.equals("register")){
			register(request,response);
		}else if(operation.equals("login")){
			login(request, response);
		}else if(operation.equals("cancel")){
			cancel(request,response);
		}
	}
	//ע���û� 
		private void cancel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.getSession().invalidate();
			request.getRequestDispatcher("/client/header.jsp").forward(request, response);
		}

		private void login(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			try{
				String username=request.getParameter("username");
				String password=request.getParameter("password");
				User user=userservice.Loging(username, MD5.encode(password));
				if(user!=null){
					request.getSession().setAttribute("user",user);
					request.getRequestDispatcher("/client/header.jsp").forward(request, response);
				}else{
					request.setAttribute("message","�û�������������û�м����˻�");
					request.getRequestDispatcher("/message.jsp").forward(request, response);
				}
				
				
			}catch(Exception e){
				request.setAttribute("message","��¼ʧ��");
				request.getRequestDispatcher("/message.jsp").forward(request, response);
			}
		}
	
	private void register(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			String cellphone=request.getParameter("cellphone");
			String address=request.getParameter("address");
			String email=request.getParameter("email");
			String newpassword=request.getParameter("newpassword");
			User user=new User();
			user.setAddress(address);
			user.setCellphone(cellphone);
			user.setEmail(email);
			user.setPassword(MD5.encode(password));
			user.setId(UUIdUtil.getIdgener());
			user.setUsername(username);
			user.setNewpassword(MD5.encode(newpassword));
			user.setActived(State.No.toString());
			user.setRandomuuid(UUIdUtil.getIdgener());//������
			
			//д�����ʼ�  ���߳�
			SendMessageThread smt=new SendMessageThread(user);
			new Thread(smt).start();
			
			userservice.register(user);
			request.setAttribute("message","��ϲ��  ע��ɹ� ϵͳ�Է��ͼ����뵽�������� �������������˻�  лл��ϣ�����");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","ע��ʧ��");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
