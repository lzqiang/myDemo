package cn.itcast.bookstore.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.itcast.bookstore.dao.OrdersDao;
import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.OrderItem;
import cn.itcast.bookstore.domain.Orders;
import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.exception.DaoException;
import cn.itcast.bookstore.utils.JdbcUtil_dbcp;

public class OrdersDaoImpl implements OrdersDao {

	@Override
	public void add(Orders order) {
		//订单项和订单一起保存  运用事务
		Connection conn=null;
		try{			
			//运用事务 连接自己控制
			QueryRunner qr=new QueryRunner();
			conn=JdbcUtil_dbcp.getConnection();
			conn.setAutoCommit(false);//开启事务
			//先保存订单
			String sql="insert into orders(id,date,totalmoney,user_id,state)values(?,?,?,?,?)";
			Object params[]={order.getId(),order.getDate(),order.getTotalmoney(),order.getUser().getId(),order.getState()};
			qr.update(conn, sql, params);
			//在保存订单项
			Set<OrderItem> items=order.getOrderItem();
			for(OrderItem item:items){
				sql="insert into orderitem(id,num,totalprice,book_id,orders_id)values(?,?,?,?,?)";
				params=new Object[]{item.getId(),item.getNum(),item.getTotalprice(),item.getBook().getId(),order.getId()};
				qr.update(conn, sql, params);
			}
			
			conn.commit();
		}catch(Exception e){
			try {
				if(conn!=null){
					conn.rollback();
					conn.commit();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
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
	public List<Orders> query(String userId) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from orders where user_id=?";
			return qr.query(sql, new BeanListHandler<Orders>(Orders.class),userId);
		}catch(Exception e){
			throw new DaoException(e);
		}
		
	}

	@Override
	public List<OrderItem> queryItem(String ordersId) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from orderitem where orders_id=?";
			return qr.query(sql, new BeanListHandler<OrderItem>(OrderItem.class),ordersId);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public List<Orders> queryByState(int state) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from Orders where state=?";
			return qr.query(sql, new BeanListHandler<Orders>(Orders.class),state);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public void update(Orders order) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="update orders set state='1' where id=?";
			Object params[]={order.getId()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public void delete(String ordersId) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="delete from orders where id=?";
			qr.update(sql,ordersId);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}
	public Books findByItemId(String Itemid){
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from books where id=(select book_id from orderitem where id=?)";
			return qr.query(sql, new BeanHandler<Books>(Books.class),Itemid);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public User findByOrderId(String orderId) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from user where id=(select user_id from orders where id=?)";
			return qr.query(sql, new BeanHandler<User>(User.class),orderId);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public Orders queryById(String orderId) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from orders where id=?";
			return qr.query(sql, new BeanHandler<Orders>(Orders.class),orderId);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}
	

}
