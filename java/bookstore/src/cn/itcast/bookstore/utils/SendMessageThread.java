package cn.itcast.bookstore.utils;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import cn.itcast.bookstore.domain.User;

public class SendMessageThread implements Runnable {
	private User user;
	public SendMessageThread(User user){
		this.user=user;
	}
	@Override
	public void run() {
		try{
			// 得到Session
			Session session = MailSession.getMailSession();
			session.setDebug(true);
			//得到发邮件的对象
			Transport ts=session.getTransport();
			ts.connect("smtp.qq.com","335892083","czxy100303212");
			MimeMessage message=getMessage(session,user);
			ts.sendMessage(message,message.getAllRecipients());
			ts.close();
		}catch(Exception e){
			throw new RuntimeException(e);
		}

	}

	public MimeMessage getMessage(Session session,User user){
		try{
			MimeMessage message=new MimeMessage(session);
			message.setFrom(new InternetAddress("335892083@qq.com"));//发件人
			message.setSubject("淘宝书店账户集合邮件");//主体
			message.setRecipients(Message.RecipientType.TO,user.getEmail());//收件人
			
			//创建正文  文本
			MimeBodyPart text=new MimeBodyPart();
			String url="http://localhost:8080/bookstore/client/activedServlet?code="+user.getRandomuuid();
			text.setContent("亲爱的"+user.getUsername()+"先生/小姐,感谢注册本网站 请点击下面的连接激活您的账户<br/><a href='"+url+"'>"+url+"</a><br>本网站的书籍是全新的最全的 <br/>","text/html;charset=utf-8");
			
			MimeMultipart mmp=new MimeMultipart();
			mmp.addBodyPart(text);
			
			message.setContent(mmp);
			message.saveChanges();
			return message;
		}catch(Exception e){
			throw new RuntimeException(e);	
		}
		
	}
}
