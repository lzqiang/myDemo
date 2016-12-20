package cn.itcast.bookstore.service;

import java.util.List;

import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.exception.IdNullException;

public interface CategoryService {
	/**
	 * ��ӷ���
	 * @param category
	 */
	public void add(Category category);
	/**
	 * ɾ������
	 * @param id
	 * @throws IdNullException
	 */
	public void del(String id);
	/**
	 * �޸ķ���
	 * @param category
	 * @throws IdNullException
	 */
	public void update(Category category);
	/**
	 * ��ȡһ������
	 * @param id
	 * @return
	 * @throws IdNullException
	 */
	public Category findById(String id);
	/**
	 * ��ȡ���з���
	 * @return
	 */
	public List<Category> findAll();
	/**
	 * �������id��ȡ����
	 * @param bookid
	 * @return
	 */
	public Category findByBookId(String bookid);
}
