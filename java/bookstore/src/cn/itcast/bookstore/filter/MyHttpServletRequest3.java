package cn.itcast.bookstore.filter;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class MyHttpServletRequest3 extends HttpServletRequestWrapper {
	private HttpServletRequest request;
	public MyHttpServletRequest3(HttpServletRequest request){
		super(request);
		this.request=request;
	}
	@Override
	public String getParameter(String name) {
		try {
			URL url=MyHttpServletRequest3.class.getResource("word.txt");
			String path=url.getPath();
			String value=request.getParameter(name);
			if(value==null){
				return value;
			}
			File file=new File(path);
			BufferedReader bufr=new BufferedReader(new InputStreamReader(new FileInputStream(file)));
			String len=null;
			while((len=bufr.readLine())!=null){
				if(value.contains(len)){
					value=value.replaceAll(len,"**");
				}
			}
			return value;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e);
		}
	
		// TODO Auto-generated method stub
		
	}
	
}
