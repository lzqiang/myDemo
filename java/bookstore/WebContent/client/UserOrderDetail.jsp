<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详细订单信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/table.css">;
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/JS/js.js"></script>
</head>
<body>
	<h3>您的详细订单如下:</h3>
	<table>
		<tr>
			<th>序号</th>
			<th>书名</th>
			<th>售价</th>
			<th>数量</th>
			<th>应收账款</th>
		</tr>
		<c:forEach items="${items }" var="item" varStatus="stat">
			<tr>
				<td>${stat.count }</td>
				<td>${item.book.name }</td>
				<td>${item.book.price }</td>
				<td>${item.num }</td>				
				<td>${item.totalprice}</td>
			</tr>
		</c:forEach>		
	</table>
	<br/><hr/>
	<table>
  		<h3>收货人详细地址</h3>
  		<tr>
  			<th>用户</th>
  			<th>手机</th>
  			<th>地址</th>
  			<th>邮箱</th>
  		</tr>
  		
  		<tr>
  			<td>${user.username }</td>
  			<td>${user.cellphone }</td>
  			<td>${user.address }</td>
  			<td>${user.email }</td>
  		</tr>
  	</table>
</body>
</html>