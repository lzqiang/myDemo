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
		 * ˼·��1.��bufferedImage���ڴ��д���ͼƬ
		 * 2.�õ�����
		 * 3.���߿�
		 * 4.������ɫ
		 * 5.��������
		 * 6.����֤��
		 * 7.ImageIO���
		 */
		//��Ҫ����
		response.setHeader("Expires","-1");
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Pragma","no-cache");
		//���ڴ��д���һ���ڴ�ͼ�� �����ó��Ⱥ͸߶�BufferedImage��
		BufferedImage image=new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
		//2�õ���ͼ��Ļ���
		Graphics g=image.getGraphics();
		//���߿�
		g.setColor(Color.blue);
		g.drawRect(0, 0, WIDTH, HEIGHT);
		//������ɫ
		g.setColor(Color.gray);
		g.fillRect(1, 1, WIDTH-2, HEIGHT-2);
		//��������9��
		g.setColor(Color.yellow);
		Random random=new Random();
		for(int i=0;i<9;i++){
			g.drawLine(random.nextInt(WIDTH), random.nextInt(HEIGHT), random.nextInt(WIDTH), random.nextInt(HEIGHT));
		}
		//����֤��
		g.setColor(Color.red);
		g.setFont(new Font("����",Font.BOLD,20));
		int x=5;
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<4;i++){
			int num=random.nextInt(9);
			g.drawString(num+"",x,20);
			x+=30;
			sb.append(num);			
		}
		//����֤����ӵ�Session��
		String code=sb.toString();
		request.getSession().setAttribute("code",MD5.encode(code));
		//���
		ImageIO.write(image,"jpeg",response.getOutputStream());
	}

}
