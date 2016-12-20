<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>没有发货页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/table.css">;
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/JS/js.js"></script>
</head>
<body>
	<center>
	<c:if test="${empty orders }">
		<h3>订单全部处理完了.....</h3>
	</c:if>
	<c:if test="${not empty orders }">	
	<h3>未处理订单如下</h3>	
	<table>
		<tr>
			<th>序号</th>
			<th>用户名</th>
			<th>下单时间</th>
			<th>订单状态</th>
			<th>总计</th>
			<th>操作</th>			
		</tr>
		<c:forEach items="${orders }" var="o" varStatus="stat">
			<tr>
				<td>${stat.count}</td>
				<td>${o.user.username}</td>
				<td>${o.date }</td>
				<td>${o.state==0?"未发货":"已发货" }</td>
				<td>${o.totalmoney }</td>
				<td>
					<a href="${pageContext.request.contextPath }/manager/OrderServlet?operation=send&orderid=${o.id}">发货</a>
				</td>
				
			</tr>
		</c:forEach>
	</table>
	</c:if>
</center>
</body>
</html>