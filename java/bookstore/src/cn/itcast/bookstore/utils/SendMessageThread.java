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
			// �õ�Session
			Session session = MailSession.getMailSession();
			session.setDebug(true);
			//�õ����ʼ��Ķ���
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
			message.setFrom(new InternetAddress("335892083@qq.com"));//������
			message.setSubject("�Ա�����˻������ʼ�");//����
			message.setRecipients(Message.RecipientType.TO,user.getEmail());//�ռ���
			
			//��������  �ı�
			MimeBodyPart text=new MimeBodyPart();
			String url="http://localhost:8080/bookstore/client/activedServlet?code="+user.getRandomuuid();
			text.setContent("�װ���"+user.getUsername()+"����/С��,��лע�᱾��վ ������������Ӽ��������˻�<br/><a href='"+url+"'>"+url+"</a><br>����վ���鼮��ȫ�µ���ȫ�� <br/>","text/html;charset=utf-8");
			
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
