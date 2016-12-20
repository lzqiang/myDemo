package cn.itcast.bookstore.test;

import org.junit.Test;

import com.sun.org.apache.bcel.internal.generic.NEW;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.service.BookService;
import cn.itcast.bookstore.service.CategoryService;
import cn.itcast.bookstore.service.impl.BooksServiceImpl;
import cn.itcast.bookstore.service.impl.CategoryServiceImpl;

public class TestService {
	private BookService service=new BooksServiceImpl();
	private CategoryService cs=new CategoryServiceImpl();
	@Test
	public void add(){
		Category c=new Category();
		cs.findById("253aa36a-cefe-43d9-a754-dbb7569ec7ea");
		for(int i=0;i<100;i++){
			Books book=new Books();
			book.setName("java"+i);
			book.setAuthor("java"+i);
			book.setCategory(c);
			service.addBook(book);
		}
	}
}
