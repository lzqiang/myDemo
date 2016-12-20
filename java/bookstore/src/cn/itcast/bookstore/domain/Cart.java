package cn.itcast.bookstore.domain;

import java.util.HashMap;
import java.util.Map;

public class Cart {
	private float totalmoney;//购物车中总价钱
	private int totalnum;//总的商品数
	//key bookid  value cartitem
	private Map<String,CartItem> map=new HashMap<String,CartItem>();
	public float getTotalmoney() {
		totalmoney=0;
		for(Map.Entry<String,CartItem> me:map.entrySet()){
			totalmoney+=me.getValue().getPrice();
		}
		return totalmoney;
	}
	
	public int getTotalnum() {
		totalnum=0;
		for(Map.Entry<String,CartItem> me:map.entrySet()){
			totalnum+=me.getValue().getNum();
		}
		return totalnum;
	}
	public void setTotalnum(int totalnum) {
		this.totalnum = totalnum;
	}
	public Map<String, CartItem> getMap() {
		return map;
	}
	public void setMap(Map<String, CartItem> map) {
		this.map = map;
	}
	//向购物车中添加一本书
	public void addBook(Books book){
		//首先判断购物车中有没有这本书
		//如果有  将num加一  没有放入
		String bookid=book.getId();
		boolean has=map.containsKey(bookid);
		if(has){
			CartItem item=map.get(bookid);
			item.setNum(item.getNum()+1);
			map.put(bookid, item);
		}else{
			//创建一个购物项
			CartItem item=new CartItem();
			item.setNum(1);
			item.setBook(book);
			map.put(bookid, item);
		}
	}
	
}
