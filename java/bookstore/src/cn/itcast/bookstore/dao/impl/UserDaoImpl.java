package cn.itcast.bookstore.dao.impl;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import cn.itcast.bookstore.dao.UserDao;
import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.exception.DaoException;
import cn.itcast.bookstore.exception.IdNullException;
import cn.itcast.bookstore.exception.NameNullException;
import cn.itcast.bookstore.utils.JdbcUtil_dbcp;

public class UserDaoImpl implements UserDao {
	@Override
	public void add(User user) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="insert into user(id,username,password,newpassword,cellphone,address,email,actived,randomuuid) values(?,?,?,?,?,?,?,?,?)";
			Object params[]={user.getId(),user.getUsername(),user.getPassword(),user.getNewpassword(),user.getCellphone(),user.getAddress(),user.getEmail(),user.getActived(),user.getRandomuuid()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}	

	@Override
	public void update(User user) throws IdNullException {
		try{
			if(user.getId()==null || user.getId().trim().equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="update user set username=?,password=?,cellphone=?,address=?,email=? where id=?";
			Object params[]={user.getUsername(),user.getPassword(),user.getCellphone(),user.getAddress(),user.getEmail(),user.getId()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public User findById(String id) {
		try{
			if(id==null || id.trim().equals("")){
				throw new IdNullException("id不能为空");
			}
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from user where id=?";
			return qr.query(sql, new BeanHandler<User>(User.class),id);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public User findByUsername(String username) {
		try{
			if(username==null || username.trim().equals("")){
				throw new NameNullException("username不能为空");
			}
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from user where username=?";
			return qr.query(sql, new BeanHandler<User>(User.class),username);
		}catch(Exception e){
			throw new DaoException(e);
		}
		
	}

	@Override
	public User findUser(String username, String password) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="select * from user where username=?and password=?";
			Object params[]={username,password};
			return qr.query(sql, new BeanHandler<User>(User.class),params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}

	@Override
	public void update(String actived,String randomuuid) {
		try{
			QueryRunner qr=new QueryRunner(JdbcUtil_dbcp.getDataSource());
			String sql="update user set actived=? where randomuuid=?";
			Object params[]={actived,randomuuid};
			qr.update(sql,params);
		}catch(Exception e){
			throw new DaoException(e);
		}
	}
	
}
