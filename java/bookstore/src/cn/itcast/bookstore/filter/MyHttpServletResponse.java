package cn.itcast.bookstore.filter;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class MyHttpServletResponse extends HttpServletResponseWrapper{
	private HttpServletResponse response;
	private ByteArrayOutputStream baos=new ByteArrayOutputStream();
	private PrintWriter pw;
	public MyHttpServletResponse(HttpServletResponse response){
		super(response);
		this.response=response;
	}
	@Override
	public ServletOutputStream getOutputStream() throws IOException {
		return new MyServletOutputStream(baos);
	}
	@Override
	public PrintWriter getWriter() throws IOException {
		pw=new PrintWriter(new OutputStreamWriter(baos,"utf-8"));
		return pw;
	}
	public byte[]getbuff(){
		if(pw!=null){
			pw.close();
			return baos.toByteArray();
		}
		if(baos!=null){
			try {
				baos.flush();
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
			return baos.toByteArray();
		}
		return null;
	}
	
}
