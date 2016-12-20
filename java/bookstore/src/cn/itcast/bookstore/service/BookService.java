package cn.itcast.bookstore.service;


import java.util.List;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.Page;
public interface BookService {
	public void addBook(Books book);
	public void deleteBook(String id);
	public void updateBook(Books book);
	public List<Books> findAll();
	public Books findById(String id);
	public Page getPagRecords(String pageNum);
	/**
	 * 根据分类获取分页数据
	 * @param startIndex
	 * @param num
	 * @param categoryId
	 * @return
	 */
	public Page getCategoryPageRecords(String pagenum,String categoryId);
}
