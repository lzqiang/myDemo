<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/table.css">;
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/JS/js.js"></script>
<title>订单列表</title>
</head>
<body>
	<center>
		<table>
			<tr>
				<th>序号</th>
				<th>订单人</th>
				<th>下单时间</th>
				<th>订单状态</th>
				<th>订单总价</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${list }" var="order" varStatus="stat">
				<tr>
					<td>${stat.count }</td>
					<td>${user.username }</td>
					<td>${order.date }</td>
					<td>${order.state==0?'未发货':'已发货' }</td>
					<td>${order.totalmoney }</td>
					<td>
						<a href="${pageContext.request.contextPath }/client/showOrderServlet?operation=UserOrderDetail&order_id=${order.id}">查看详细</a>
						<a href="#">删除</a>
					</td>			
				</tr>
			</c:forEach>
		</table>
	</center>
</body>
</html>