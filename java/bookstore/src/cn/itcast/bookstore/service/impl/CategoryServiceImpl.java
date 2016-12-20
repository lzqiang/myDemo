package cn.itcast.bookstore.service.impl;

import java.util.List;

import cn.itcast.bookstore.dao.CategoryDao;
import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.exception.IdNullException;
import cn.itcast.bookstore.service.CategoryService;
import cn.itcast.bookstore.utils.DaoFactory;
import cn.itcast.bookstore.utils.UUIdUtil;

public class CategoryServiceImpl implements CategoryService {
	private CategoryDao dao=DaoFactory.getInstance().createDao("cn.itcast.bookstore.dao.impl.CategoryDaoImpl",CategoryDao.class);

	@Override
	public void add(Category category) {
		category.setId(UUIdUtil.getIdgener());
		dao.add(category);
	}

	@Override
	public void del(String id) {
		try {
			dao.del(id);
		} catch (IdNullException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void update(Category category) {
		try {
			dao.update(category);
		} catch (IdNullException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Category findById(String id) {
		try {
			return dao.findById(id);
		} catch (IdNullException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Category> findAll() {
		return dao.findAll();
	}

	@Override
	public Category findByBookId(String bookid) {
		return dao.findByBookId(bookid);
	}
	
}
