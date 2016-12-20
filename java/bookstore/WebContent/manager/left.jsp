<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>分类管理</h3>
	&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/manager/addCategory.jsp" target="body">添加分类</a><br/>
	&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/manager/categoryServlet?operation=showCategory" target="body">查看分类</a><br/>
	<h3>图书管理</h3>
	&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=showAddBook" target="body">添加图书</a><br/>
	&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks" target="body">查看图书</a><br/>
	<h3>订单管理</h3>
	&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/manager/OrderServlet?operation=listAllNo" target="body">未处理订单</a><br/>
	&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/manager/OrderServlet?operation=listAllYes" target="body">处理订单</a><br/>
</body>
</html>