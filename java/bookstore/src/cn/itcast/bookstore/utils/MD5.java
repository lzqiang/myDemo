package cn.itcast.bookstore.utils;

import java.security.MessageDigest;

import sun.misc.BASE64Encoder;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import com.sun.xml.internal.ws.encoding.xml.XMLMessage.MessageDataSource;

public class MD5 {
	public static String encode(String value){
		try{
			MessageDigest md=MessageDigest.getInstance("md5");
			byte b[]=md.digest(value.getBytes());
			BASE64Encoder base64=new BASE64Encoder();
			return base64.encode(b);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
}
