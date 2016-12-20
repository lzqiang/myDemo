package cn.itcast.bookstore.dao;

import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.exception.IdNullException;
import cn.itcast.bookstore.exception.NameNullException;

public interface UserDao {
	public void add(User user);
	public void update(User user)throws IdNullException;
	public User findById(String id)throws IdNullException;
	public User findUser(String username,String password);
	public User findByUsername(String username)throws NameNullException;
	public void update(String actived,String randomuuid);
}
