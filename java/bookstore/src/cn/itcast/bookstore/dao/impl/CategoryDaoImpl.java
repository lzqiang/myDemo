package cn.itcast.bookstore.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.itcast.bookstore.dao.CategoryDao;
import cn.itcast.bookstore.domain.Category;
import cn.itcast.bookstore.exception.DaoException;
import cn.itcast.bookstore.exception.IdNullException;
import cn.itcast.bookstore.utils.JdbcUtil_dbcp;

public class CategoryDaoImpl implements CategoryDao {

	@Override
	public void add(Category category) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="insert into category(id,name,description) values(?,?,?)";
			Object params[]={category.getId(),category.getName(),category.getDescription()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public void del(String id) throws IdNullException {
		Connection  conn=null;
		try{
			if(id==null || id.trim().equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner();
			conn=JdbcUtil_dbcp.getConnection();
			conn.setAutoCommit(false);
			String sql="delete from orderitem where book_id=(select id from books where category_id=?)";
			qr.update(conn,sql, id);
			sql="delete from books where category_id=?";
			qr.update(conn, sql, id);
			sql="delete from category where id=?";
			qr.update(conn, sql, id);
			conn.commit();
		}catch(Exception e){
			if(conn!=null){
				try {
					conn.rollback();
					conn.commit();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				
			}
			throw new DaoException(e);
		}finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(Category category) throws IdNullException {
		try{
			if(category.getId()==null || category.getId().trim().equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="update  category set name=?,description=? where id=?";
			Object params[]={category.getName(),category.getDescription(),category.getId()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public Category findById(String id) throws IdNullException {
		try{
			if(id==null || id.trim().equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from category where id=?";
			return qr.query(sql, id,new BeanHandler<Category>(Category.class));
		}catch(Exception e){
			throw new DaoException(e);
		}
	}
	public Category findByBookId(String bookid){
		try{
			if(bookid==null || bookid.trim().equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from category where id=(select category_id from books where id=?)";
			return qr.query(sql, new BeanHandler<Category>(Category.class),bookid);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	@Override
	public List<Category> findAll() {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from category";
			return qr.query(sql,new BeanListHandler<Category>(Category.class));
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

}
