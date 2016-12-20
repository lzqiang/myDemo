package cn.itcast.bookstore.service;

import java.util.List;

import cn.itcast.bookstore.domain.Books;
import cn.itcast.bookstore.domain.OrderItem;
import cn.itcast.bookstore.domain.Orders;
import cn.itcast.bookstore.domain.User;



public interface OrdersService {
		/**
		 * ���涩�� ͬʱ���涩����
		 * @param order
		 */
		public void add(Orders order);
		/**
		 * �����û���id��ѯ�䶩��  �鿴�Լ��Ķ���
		 * @param userId
		 */
		public List<Orders> query(String userId);
		/**
		 * ���ݶ���id��ѯ������  ��ϸ��ѯ
		 * @param ordersId
		 * @return
		 */
		List<OrderItem> queryItem(String ordersId);
		/**
		 * ���ݶ���״̬��ѯ����
		 * @param state
		 * @return
		 */
		List<Orders> queryByState(int state);
		/**
		 * �޸Ķ���
		 * @param order
		 */
		public void update(Orders order);
		/**
		 * ���ݶ�����ɾ������
		 * @param ordersId
		 */
		public void delete(String ordersId);
		/**
		 * ���ݶ������ȡ��
		 * @param Itemid
		 * @return
		 */
		public Books findByItemId(String Itemid);
		/**
		 * ���ݶ����Ż�ȡ�û�
		 * @param orderId
		 * @return
		 */
		public User findByOrderId(String orderId);
		/**
		 * ���ݶ���id��ȡ����
		 * @param orderId
		 * @return
		 */
		public Orders queryById(String orderId);
	}

