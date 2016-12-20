package cn.itcast.bookstore.filter;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class MyHttpServletRequest1 extends HttpServletRequestWrapper {
	private HttpServletRequest request;
	public MyHttpServletRequest1(HttpServletRequest request) {
		super(request);
		this.request=request;
	}
	@Override
	public String getParameter(String name) {
		String value=request.getParameter(name);
		if(value==null){
			return null;
		}
		if(request.getMethod().equalsIgnoreCase("get")){
			try {
				value=new String(value.getBytes("iso-8859-1"),request.getCharacterEncoding());
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return value;
	}
	
}
