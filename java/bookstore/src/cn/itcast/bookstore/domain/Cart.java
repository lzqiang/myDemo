package cn.itcast.bookstore.domain;

import java.util.HashMap;
import java.util.Map;

public class Cart {
	private float totalmoney;//���ﳵ���ܼ�Ǯ
	private int totalnum;//�ܵ���Ʒ��
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
	//���ﳵ�����һ����
	public void addBook(Books book){
		//�����жϹ��ﳵ����û���Ȿ��
		//�����  ��num��һ  û�з���
		String bookid=book.getId();
		boolean has=map.containsKey(bookid);
		if(has){
			CartItem item=map.get(bookid);
			item.setNum(item.getNum()+1);
			map.put(bookid, item);
		}else{
			//����һ��������
			CartItem item=new CartItem();
			item.setNum(1);
			item.setBook(book);
			map.put(bookid, item);
		}
	}
	
}
