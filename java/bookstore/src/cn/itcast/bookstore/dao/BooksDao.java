package cn.itcast.bookstore.dao;

import java.util.List;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.exception.IdNullException;

public interface BooksDao {
	/**
	 * ���ͼ��
	 * @param book
	 */
	public void addBook(Books book);
	public void deleteBook(String id)throws IdNullException;
	public void updateBook(Books book)throws IdNullException;
	public List<Books> findAll();
	public Books findById(String id)throws IdNullException;
	/**
	 * ���ݷ����ҳ
	 * @param categoryId  ���id
	 * @return
	 */
	public int getRecored(String categoryId);
	/**
	 * ��ȡ�ܼ�¼��
	 * @return
	 */
	public int getRecored();
	/**
	 *��ȡ��ҳ����
	 * @param startIndex  ��ʼ�Ǳ꣨��0��ʼ��
	 * @param num  ��ʾ����ҳ��
	 * @return List<Books>
	 */
	public List<Books> getPageRecords(int startIndex,int num);
	/**
	 * ���ݷ����ȡ��ҳ����
	 * @param startIndex
	 * @param num
	 * @param categoryId
	 * @return
	 */
	public List<Books> getCategoryPageRecords(int startIndex,int num,String categoryId);
}
