package cn.itcast.bookstore.service;

import java.util.List;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.OrderItem;
import cn.itcast.bookstore.domain.Orders;
import cn.itcast.bookstore.domain.User;



public interface OrdersService {
		/**
		 * 保存订单 同时保存订单项
		 * @param order
		 */
		public void add(Orders order);
		/**
		 * 根据用户的id查询其订单  查看自己的订单
		 * @param userId
		 */
		public List<Orders> query(String userId);
		/**
		 * 根据订单id查询订单项  详细查询
		 * @param ordersId
		 * @return
		 */
		List<OrderItem> queryItem(String ordersId);
		/**
		 * 根据订单状态查询订单
		 * @param state
		 * @return
		 */
		List<Orders> queryByState(int state);
		/**
		 * 修改订单
		 * @param order
		 */
		public void update(Orders order);
		/**
		 * 根据订单号删除订单
		 * @param ordersId
		 */
		public void delete(String ordersId);
		/**
		 * 根据订单项获取书
		 * @param Itemid
		 * @return
		 */
		public Books findByItemId(String Itemid);
		/**
		 * 根据订单号获取用户
		 * @param orderId
		 * @return
		 */
		public User findByOrderId(String orderId);
		/**
		 * 根据订单id获取订单
		 * @param orderId
		 * @return
		 */
		public Orders queryById(String orderId);
	}

