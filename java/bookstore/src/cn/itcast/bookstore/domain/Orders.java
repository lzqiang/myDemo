package cn.itcast.bookstore.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class Orders {
	private String id;//作为订单号  
	private Date date;//下单日期
	private float totalmoney;//订单总金额
	private User user;//下单人
	private int state;//订单状态  0未发货 1已发货
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
