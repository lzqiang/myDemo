package cn.itcast.bookstore.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CharacterEncodingFilter implements Filter{
	private FilterConfig filterConfig;
	private String defaultEncoding="utf-8";
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig=filterConfig;
	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response=(HttpServletResponse)resp;
				
		//获取配置参数encode
		//若没有获取用默认的
		String value=filterConfig.getInitParameter("encode");
		if(value==null){
			value=defaultEncoding;
		}
		request.setCharacterEncoding(value);
		response.setContentType("text/html;charset=utf-8");
		MyHttpServletRequest1 myrequest1=new MyHttpServletRequest1(request);
		chain.doFilter(myrequest1, response);
		System.out.println("字符过滤");
	}

	@Override
	public void destroy() {
		
	}

}
