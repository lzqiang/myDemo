package cn.itcast.bookstore.service.impl;

import java.util.List;

import cn.itcast.bookstore.dao.BooksDao;
import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.Page;
import cn.itcast.bookstore.exception.IdNullException;
import cn.itcast.bookstore.service.BookService;
import cn.itcast.bookstore.utils.DaoFactory;
import cn.itcast.bookstore.utils.UUIdUtil;

public class BooksServiceImpl implements BookService {
	private BooksDao dao=DaoFactory.getInstance()
			.createDao("cn.itcast.bookstore.dao.impl.BooksDaoImpl",BooksDao.class);
	@Override
	public void addBook(Books book) {
		book.setId(UUIdUtil.getIdgener());
		dao.addBook(book);
	}

	@Override
	public void deleteBook(String id) {
		try {
			dao.deleteBook(id);
		} catch (IdNullException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateBook(Books book) {
		try {
			dao.updateBook(book);
		} catch (IdNullException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Books> findAll() {
		return dao.findAll();
	}

	@Override
	public Books findById(String id) {
		try {
			return dao.findById(id);
		} catch (IdNullException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Page getPagRecords(String pageNum) {
		//获取总记录数 
		int totalrecord=dao.getRecored();
		if(pageNum==null || pageNum.trim().equals("")){
			//第一次
			Page page=new Page(totalrecord,1);
			List<Books> list=dao.getPageRecords(page.getStartIndex(),page.getPagesize());
			page.setList(list);
			return page;
		}else {
			int num=Integer.parseInt(pageNum);
			Page page=new Page(totalrecord,num);
			List<Books> list=dao.getPageRecords(page.getStartIndex(),page.getPagesize());
			page.setList(list);
			return page;
		}
		
	}

	@Override
	public Page getCategoryPageRecords(String pageNum, String categoryId) {
		int totalrecord=dao.getRecored(categoryId);
		Page page=null;
		if(pageNum==null || pageNum.trim().equals("")){
			page=new Page(totalrecord,1);
		}else{
			page=new Page(totalrecord,Integer.parseInt(pageNum));
		}
		List list=dao.getCategoryPageRecords(page.getStartIndex(),page.getPagesize(),categoryId);
		page.setList(list);
		return page;
	}
}
