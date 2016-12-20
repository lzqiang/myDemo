package cn.itcast.bookstore.dao;

import java.util.List;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.exception.IdNullException;

public interface BooksDao {
	/**
	 * 添加图书
	 * @param book
	 */
	public void addBook(Books book);
	public void deleteBook(String id)throws IdNullException;
	public void updateBook(Books book)throws IdNullException;
	public List<Books> findAll();
	public Books findById(String id)throws IdNullException;
	/**
	 * 根据分类分页
	 * @param categoryId  类别id
	 * @return
	 */
	public int getRecored(String categoryId);
	/**
	 * 获取总记录数
	 * @return
	 */
	public int getRecored();
	/**
	 *获取分页数据
	 * @param startIndex  开始角标（从0开始）
	 * @param num  显示的总页数
	 * @return List<Books>
	 */
	public List<Books> getPageRecords(int startIndex,int num);
	/**
	 * 根据分类获取分页数据
	 * @param startIndex
	 * @param num
	 * @param categoryId
	 * @return
	 */
	public List<Books> getCategoryPageRecords(int startIndex,int num,String categoryId);
}
