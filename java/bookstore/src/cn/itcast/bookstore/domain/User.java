package cn.itcast.bookstore.domain;

public class User {
	private String id;
	private String username;
	private String password;
	private String newpassword;
	private String cellphone;
	private String address;
	private String email;
	private String actived;//是否激活  yes激活  no位激活
	private String randomuuid;//激活码
	
	
	public String getActived() {
		return actived;
	}
	public void setActived(String actived) {
		this.actived = actived;
	}
	public String getRandomuuid() {
		return randomuuid;
	}
	public void setRandomuuid(String randomuuid) {
		this.randomuuid = randomuuid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNewpassword() {
		return newpassword;
	}
	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
