package cn.itcast.bookstore.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.bookstore.dao.BooksDao;
import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.exception.DaoException;
import cn.itcast.bookstore.exception.IdNullException;
import cn.itcast.bookstore.utils.JdbcUtil_dbcp;

public class BooksDaoImpl implements BooksDao {
	@Override
	public void addBook(Books book) {
		try{
		QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
		String sql="insert into books(id,name,price,author,description,images,category_id) values(?,?,?,?,?,?,?)";
		Object params[]={book.getId(),book.getName(),book.getPrice(),book.getAuthor(),book.getDescription(),book.getImages(),book.getCategory().getId()};
		qr.update(sql, params);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deleteBook(String id) throws IdNullException {
		Connection conn=null;
		try{
			if(id==null || id.equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner();
			conn=JdbcUtil_dbcp.getConnection();
			conn.setAutoCommit(false);
			String sql="delete from orderitem where book_id=?";
			qr.update(conn,sql, id);
			sql="delete from books where id=?";
			qr.update(conn, sql, id);			
			conn.commit();
		}catch(Exception e){
			try {
				conn.rollback();
				conn.commit();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
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
	public void updateBook(Books book) throws IdNullException {
		try{
			if(book.getId()==null || book.getId().equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="update books set name=?,price=?,author=?,description=?,images=?,category_id=? where id=?";
			Object params[]={book.getName(),book.getPrice(),book.getAuthor(),book.getDescription(),book.getImages(),book.getCategory().getId(),book.getId()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<Books> findAll() {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from books";
			return qr.query(sql, new BeanListHandler<Books>(Books.class));
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}

	@Override
	public Books findById(String id) throws IdNullException {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from books where id=?";
			return qr.query(sql, new BeanHandler<Books>(Books.class),id);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}

	@Override
	public int getRecored(String categoryId) {
		try{
		QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
		String sql="select count(*) from books where category_id=?";
		Long num=(Long)qr.query(sql,new ScalarHandler(1),categoryId);	
		return num.intValue();
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public int getRecored() {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select count(*) from books";
			Long num=(Long)qr.query(sql, new ScalarHandler(1));
			return num.intValue();
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public List<Books> getPageRecords(int startIndex, int num) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from books limit ?,?";
			Object params[]={startIndex,num};
			return qr.query(sql, new BeanListHandler<Books>(Books.class), params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public List<Books> getCategoryPageRecords(int startIndex, int num,
			String categoryId) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from books where category_id=? limit ?,?";
			Object params[]={categoryId,startIndex,num};
			return qr.query(sql, new BeanListHandler<Books>(Books.class), params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}
	
	

}
