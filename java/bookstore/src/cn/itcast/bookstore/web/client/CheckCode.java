package cn.itcast.bookstore.web.client;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.bookstore.utils.MD5;

public class CheckCode extends HttpServlet {
	public static final int WIDTH=120;
	public static final int HEIGHT=25;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 思路：1.用bufferedImage在内存中创建图片
		 * 2.得到画笔
		 * 3.花边框
		 * 4.画背景色
		 * 5.画干扰线
		 * 6.画验证码
		 * 7.ImageIO输出
		 */
		//不要缓存
		response.setHeader("Expires","-1");
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Pragma","no-cache");
		//在内存中创建一个内存图像 并设置长度和高度BufferedImage；
		BufferedImage image=new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
		//2得到该图像的画笔
		Graphics g=image.getGraphics();
		//画边框
		g.setColor(Color.blue);
		g.drawRect(0, 0, WIDTH, HEIGHT);
		//画背景色
		g.setColor(Color.gray);
		g.fillRect(1, 1, WIDTH-2, HEIGHT-2);
		//画干扰线9条
		g.setColor(Color.yellow);
		Random random=new Random();
		for(int i=0;i<9;i++){
			g.drawLine(random.nextInt(WIDTH), random.nextInt(HEIGHT), random.nextInt(WIDTH), random.nextInt(HEIGHT));
		}
		//画验证码
		g.setColor(Color.red);
		g.setFont(new Font("宋体",Font.BOLD,20));
		int x=5;
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<4;i++){
			int num=random.nextInt(9);
			g.drawString(num+"",x,20);
			x+=30;
			sb.append(num);			
		}
		//将验证码添加到Session中
		String code=sb.toString();
		request.getSession().setAttribute("code",MD5.encode(code));
		//输出
		ImageIO.write(image,"jpeg",response.getOutputStream());
	}

}
