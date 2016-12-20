1.准备jar包
2.建立软件包
3.准备过滤器及工具类
	CharacterEncodingFilter  过滤编码
	HtmlFilter   过滤脏话
	JdbcUtil
	DaoFactory
4.页面框架
	client：放前台
		index.jsp
		    header.jsp
		    body.jsp
	manager：放后台
	  manager.jsp
	     header.jsp
	     left.jsp
	     body.jsp
	images:放图片
//数据库
create database livestore;
use livestore;
create table category
(
	id varchar(40) primary key,
	name varchar(40) not null unique,
	description varchar(255)
);
create table books
(
	id varchar(40) primary key,
	name varchar(40) not null unique,
	price float(8,2),
	author varchar(40),
	description varchar(255),
	images varchar(40),
	category_id varchar(40),
	
	constraint category_id_foreign foreign key(category_id) references category(id)
	
);

create table user
(
	id varchar(40) primary key,
	username varchar(40) not null unique,
	password varchar(40),
	newpassword varchar(40),
	cellphone varchar(40),
	address varchar(40),
	email varchar(40)，
	actived varchar(100),
	randomuuid varchar(200) unique
);
create table orders
(
	id varchar(40) primary key,
	date datetime;
	totalmoney float(10,2),
	user_id varchar(40),
	state int,
	constraint user_id_fk foreign key(user_id) references user(id)	
);
create tableorderitem
(
	id varchar(40) primary key,
	num int,
	totalprice float(10,2),
	book_id varchar(40),
	orders_id varchar(40),
	constraint book_id_fk foreign key(book_id) references book(id),
	constraint orders_id_fk foreign key(orders_id) references orders(id)
	
)