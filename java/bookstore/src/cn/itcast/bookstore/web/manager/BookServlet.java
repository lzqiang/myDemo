package cn.itcast.bookstore.web.manager;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.domain.Page;
import cn.itcast.bookstore.service.BookService;
import cn.itcast.bookstore.service.CategoryService;
import cn.itcast.bookstore.service.impl.BooksServiceImpl;
import cn.itcast.bookstore.service.impl.CategoryServiceImpl;
import cn.itcast.bookstore.utils.UUIdUtil;

public class BookServlet extends HttpServlet {
	CategoryService categoryservice=new CategoryServiceImpl();
	BookService bookservice=new BooksServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation=request.getParameter("operation");
		if(operation.equals("showAddBook")){
			showAddBook(request,response);
		}else if(operation.equals("addBookSave")){
			addBookSave(request,response);
		}else if(operation.equals("ListBooks")){
			ListBooks(request,response);
		}else if(operation.equals("showImage")){
			showImage(request,response);
		}else if(operation.equals("deleteBook")){
			deleteBook(request,response);
		}else if(operation.equals("updateBook")){
			updateBook(request,response);
		}
	}
	private void updateBook(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
		String bookid=request.getParameter("bookid");
		Books book=bookservice.findById(bookid);
		//转向修改页面
		List<Category> list=categoryservice.findAll();
		Category category=categoryservice.findByBookId(bookid);
		book.setCategory(category);
		request.setAttribute("Categorys",list);
		request.setAttribute("book",book);
		request.getRequestDispatcher("/manager/updateBook.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","跳转失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}
	private void deleteBook(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String bookid=request.getParameter("bookid");
			bookservice.deleteBook(bookid);
			request.setAttribute("message","删除成功");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","删除失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}
	private void showImage(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
//		String ImageName=request.getParameter("imageName");
			String ImageName=request.getParameter("imageName");
			String file=request.getContextPath()+"\\images\\"+ImageName;
			request.setAttribute("imageUrl",file);
			System.out.println(file);
			request.getRequestDispatcher("/manager/showImage.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","显示图片失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}
	private void ListBooks(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String pageNum=request.getParameter("pageNum");
			Page page=bookservice.getPagRecords(pageNum);
			request.setAttribute("page",page);			
			request.getRequestDispatcher("/manager/ListBooks.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","显示图书失败");
			request.getRequestDispatcher("message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}
	private void addBookSave(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
		//文件上传
			DiskFileItemFactory factory=new DiskFileItemFactory();
			ServletFileUpload upload=new ServletFileUpload(factory);
			upload.setHeaderEncoding("utf-8");
			Books book=new Books();
			//判断是不是文件上传的表单
			if(!upload.isMultipartContent(request)){
				return ;
			}
			//解析
			List<FileItem> items=upload.parseRequest(request);
			for(FileItem item:items){
				//普通字段
				if(item.isFormField()){
					String name=item.getFieldName();
					String value=item.getString("utf-8");
					if(name.equals("category")){
						book.setCategory(categoryservice.findById(value));
					}else{
						BeanUtils.setProperty(book, name, value);
					}
				}else{
					//要上传的
					String fileName=item.getName();
					fileName=UUIdUtil.getIdgener()+"_"+fileName.substring(fileName.lastIndexOf("\\")+1);
					book.setImages(fileName);
					//存放目录
					String realPath=getServletContext().getRealPath("images");
					String realfile=realPath+"\\"+fileName;					
					InputStream in=item.getInputStream();
					OutputStream out=new FileOutputStream(realfile);
					byte[]buf=new byte[1024];
					int len=-1;
					while((len=in.read(buf))!=-1){
						out.write(buf,0,len);
					}
					out.close();
					in.close();
					item.delete();
				}
			}
			bookservice.addBook(book);
			request.setAttribute("message","添加成功");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","添加失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}

	private void showAddBook(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//获取分类数据  转向添加页码
		try{
			List<Category> list=categoryservice.findAll();
			request.setAttribute("Categorys",list);
			request.getRequestDispatcher("/manager/addBooks.jsp").forward(request, response);
		}catch(Exception e){
			request.setAttribute("message","跳转失败");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			throw new RuntimeException(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
