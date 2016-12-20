<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车列表</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/table.css">;
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/JS/js.js"></script>
</head>
<body>
	<center>
	<c:if test="${not empty shopcart.map }">
	<table>
		<tr>
			<th>序号</th>
			<th>书名</th>
			<th>作者</th>
			<th>单价</th>
			<th>数量</th>
			<th>小计</th>
			<th>操作</th>			
		</tr>
		<c:forEach items="${shopcart.map }" var="me" varStatus="stat">
			<tr>
			<td>${stat.count}</td>
			<td>${me.value.book.name}</td>
			<td>${me.value.book.author }</td>
			<td>${me.value.book.price }</td>
			<td>${me.value.num }</td>
			<td>${me.value.price }</td>
			<td>
				<a href="${pageContext.request.contextPath }/client/BuyServlet?operation=deleteCartBook&bookid=${me.value.book.id}">删除</a>
			</td>	
			</tr>	
		</c:forEach>
		<tr>
			<td><a href="${pageContext.request.contextPath }/client/BuyServlet?operation=clear">清空购物车</a></td>
			<td>总数量</td>
			<td colspan="2">${shopcart.totalnum}</td>
			<td >总金额</td>
			<td colspan="2">${shopcart.totalmoney }</td>
		</tr>	
		<tr>
			<th colspan="7">
				<a href="${pageContext.request.contextPath}/client/BuyServlet?operation=genorder">生成订单</a>
			</th>
		</tr>	
		</c:if>		
	</table>
	<c:if test="${empty shopcart.map}">
			<h1>没有购买任何书</h1>
		</c:if>
	</center>
</body>
</html>