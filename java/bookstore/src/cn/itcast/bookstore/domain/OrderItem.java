package cn.itcast.bookstore.domain;


public class OrderItem {
	private String id;
	private int num;//����
	private float totalprice;//������Ʒ���ܼ�
	private Books book;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public float getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(float totalprice) {
		this.totalprice = totalprice;
	}
	public Books getBook() {
		return book;
	}
	public void setBook(Books book) {
		this.book = book;
	}
	
	
}
