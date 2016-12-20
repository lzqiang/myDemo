package cn.itcast.bookstore.service.impl;

import java.util.List;

import cn.itcast.bookstore.dao.OrdersDao;
import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.OrderItem;
import cn.itcast.bookstore.domain.Orders;
import cn.itcast.bookstore.domain.User;
import cn.itcast.bookstore.service.OrdersService;
import cn.itcast.bookstore.utils.DaoFactory;

public class OrdersServiceImpl implements OrdersService {
	private OrdersDao dao=DaoFactory.getInstance().createDao("cn.itcast.bookstore.dao.impl.OrdersDaoImpl",OrdersDao.class);
	@Override
	public void add(Orders order) {
		dao.add(order);
	}

	@Override
	public List<Orders> query (String userId) {
		return  dao.query(userId);
	}

	@Override
	public List<OrderItem> queryItem(String ordersId) {
		return dao.queryItem(ordersId);
	}

	@Override
	public List<Orders> queryByState(int state) {
		return dao.queryByState(state);
	}

	@Override
	public void update(Orders order) {
		dao.update(order);
	}

	@Override
	public void delete(String ordersId) {
		dao.delete(ordersId);
	}

	@Override
	public User findByOrderId(String orderId) {
		return dao.findByOrderId(orderId);
	}

	@Override
	public Books findByItemId(String Itemid) {
		return dao.findByItemId(Itemid);
	}

	@Override
	public Orders queryById(String orderId) {
		return dao.queryById(orderId);
	}
	
}
