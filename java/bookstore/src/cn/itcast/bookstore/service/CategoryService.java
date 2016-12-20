package cn.itcast.bookstore.service;

import java.util.List;

import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.exception.IdNullException;

public interface CategoryService {
	/**
	 * 添加分类
	 * @param category
	 */
	public void add(Category category);
	/**
	 * 删除分类
	 * @param id
	 * @throws IdNullException
	 */
	public void del(String id);
	/**
	 * 修改分类
	 * @param category
	 * @throws IdNullException
	 */
	public void update(Category category);
	/**
	 * 获取一个分类
	 * @param id
	 * @return
	 * @throws IdNullException
	 */
	public Category findById(String id);
	/**
	 * 获取所有分类
	 * @return
	 */
	public List<Category> findAll();
	/**
	 * 根据书的id获取分类
	 * @param bookid
	 * @return
	 */
	public Category findByBookId(String bookid);
}
