package cn.itcast.bookstore.service;

import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.exception.IdNullException;

public interface UserService {
	public void register(User user);
	public void update(User user);
	public User findById(String id);
	public User findByUsername(String username);
	public User Loging(String username,String password);
	public void active(String randomuuid);
}
