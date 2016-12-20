package cn.itcast.bookstore.domain;

public class CartItem {
	private int num;//单个商品的个数
	private float price;//单个商品的及格和  小计
	private Books book;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public float getPrice() {
		return book.getPrice()*num;
	}
	
	public Books getBook() {
		return book;
	}
	public void setBook(Books book) {
		this.book = book;
	}
	
	
}
