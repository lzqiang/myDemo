package cn.itcast.bookstore.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class MyHttpServletRequest2 extends HttpServletRequestWrapper {
	private HttpServletRequest request;
	public MyHttpServletRequest2(HttpServletRequest request) {
		super(request);
		this.request=request;
	}
	@Override
	public String getParameter(String name) {
		String value=request.getParameter(name);
		if(value==null){
			return value;
		}
		return filter(value);
	}
	 public  String filter(String message) {

	        if (message == null)
	            return (null);

	        char content[] = new char[message.length()];
	        message.getChars(0, message.length(), content, 0);
	        StringBuffer result = new StringBuffer(content.length + 50);
	        for (int i = 0; i < content.length; i++) {
	            switch (content[i]) {
	            case '<':
	                result.append("&lt;");
	                break;
	            case '>':
	                result.append("&gt;");
	                break;
	            case '&':
	                result.append("&amp;");
	                break;
	            case '"':
	                result.append("&quot;");
	                break;
	            default:
	                result.append(content[i]);
	            }
	        }
	        return (result.toString());

	    }
	
}
