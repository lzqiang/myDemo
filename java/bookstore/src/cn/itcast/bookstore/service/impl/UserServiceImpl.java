package cn.itcast.bookstore.service.impl;

import cn.itcast.bookstore.dao.UserDao;
import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.exception.IdNullException;
import cn.itcast.bookstore.exception.NameNullException;
import cn.itcast.bookstore.service.UserService;
import cn.itcast.bookstore.utils.DaoFactory;
import cn.itcast.bookstore.utils.State;

public class UserServiceImpl implements UserService {
	private UserDao dao=DaoFactory.getInstance().createDao("cn.itcast.bookstore.dao.impl.UserDaoImpl",UserDao.class);
	@Override
	public void register(User user) {
		dao.add(user);
	}

	@Override
	public void update(User user) {
		try {
			dao.update(user);
		} catch (IdNullException e) {
			e.printStackTrace();
		}
	}

	@Override
	public User findById(String id) {
		try {
			return dao.findById(id);
		} catch (IdNullException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public User findByUsername(String username) {
		try {
			return dao.findByUsername(username);
		} catch (NameNullException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public User Loging(String username, String password) {
		User user=dao.findUser(username, password);
		if(user==null){
			return null;
		}else{
			if(user.getActived().equals(State.No.toString())){
				return null;
			}else{
				return user;
			}
		}
	}
	public void active(String randomuuid) {
		dao.update(State.Yes.toString(), randomuuid);
	}
	
}
