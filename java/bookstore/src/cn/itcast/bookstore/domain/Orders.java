package cn.itcast.bookstore.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class Orders {
	private String id;//��Ϊ������  
	private Date date;//�µ�����
	private float totalmoney;//�����ܽ��
	private User user;//�µ���
	private int state;//����״̬  0δ���� 1�ѷ���
	private Set<OrderItem> orderItem=new HashSet<OrderItem>();
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public float getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(float totalmoney) {
		this.totalmoney = totalmoney;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Set<OrderItem> getOrderItem() {
		return orderItem;
	}
	public void setOrderItem(Set<OrderItem> orderItem) {
		this.orderItem = orderItem;
	}
	
	
}
