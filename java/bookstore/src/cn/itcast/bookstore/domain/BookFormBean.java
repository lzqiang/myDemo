package cn.itcast.bookstore.domain;

import java.util.HashMap;
import java.util.Map;

public class BookFormBean {
	private String name;
	private String price;
	private String author;
	private String description;
	private String images;
	private String category_id;
	//��װ������Ϣ  key�Ǵ����������  value�Ǵ�����Ϣ��
	public Map<String,String> errors=new HashMap<String,String>();
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public Map<String, String> getErrors() {
		return errors;
	}
	public void setErrors(Map<String, String> errors) {
		this.errors = errors;
	}
	//��֤
	public boolean valiate(){
		/*
		 * private String name;
	private String price;
	private String author;
	private String description;
	private String images;
	private String category_id;;
		 */
		boolean isok=true;
		if(name==null || name.trim().equals("")){
			errors.put("name","��������Ϊ��");
			isok=false;
		}
		if(price==null || price.trim().equals("")){
			errors.put("price","�۸���Ϊ��");
		}else{
			try{
				Float.parseFloat(price);
			}catch(Exception e){
				errors.put("price","����������");
				isok=false;
			}
		}
		if(author==null || author.trim().equals("")){
			errors.put("author","���߲���Ϊ��");
			isok=false;
		}
		if(images==null || images.trim().equals("")){
			errors.put("images","���ϴ�ͼƬ");
		}
		return isok;
	}
}
