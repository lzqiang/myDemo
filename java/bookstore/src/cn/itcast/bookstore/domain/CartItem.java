package cn.itcast.bookstore.domain;

public class CartItem {
	private int num;//������Ʒ�ĸ���
	private float price;//������Ʒ�ļ����  С��
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
