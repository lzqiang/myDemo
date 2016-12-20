package cn.itcast.bookstore.utils;

import java.util.Properties;

import javax.mail.Session;

public class MailSession {
	public static Session getMailSession(){
		Properties props=new Properties();
		props.setProperty("mail.host","smtp.qq.com");
		props.setProperty("mail.transport.protocol","smtp");
		Session session=Session.getInstance(props);
		return session;
	}
}
