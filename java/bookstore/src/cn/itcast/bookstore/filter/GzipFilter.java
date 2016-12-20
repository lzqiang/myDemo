package cn.itcast.bookstore.filter;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GzipFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response=(HttpServletResponse)resp;
			
		MyHttpServletResponse mresponse=new MyHttpServletResponse(response);
		chain.doFilter(request, mresponse);
		//�ӻ�����������
		byte b[]=mresponse.getbuff();//ԭʼ���е�����
		System.out.println(b.length+"Ԫ����");
		//ѹ������
		ByteArrayOutputStream bout=new ByteArrayOutputStream();
		GZIPOutputStream gout=new GZIPOutputStream(bout);
		gout.write(b);		
		gout.close();
		
		byte gb[]=bout.toByteArray();//�õ�ѹ���������
		System.out.println(gb.length+"ѹ����");
		response.setHeader("Content-Encoding","gzip");
		response.setContentLength(gb.length);
		response.setContentType("text/html;charset=utf-8");
		response.getOutputStream().write(gb);		
	}

	@Override
	public void destroy() {
		
	}

}
