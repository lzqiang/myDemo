<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="text-align: center;">
	<h1>淘宝书店</h1>
	<c:if test="${empty user }">
	<form action="${pageContext.request.contextPath }/client/UserServlet?operation=login" method="post">
		用户名:<input type="text" name="username"/>
		密&nbsp;码:<input type="password" name="password"/>
		<input type="submit" value="登录"/>
		<input type="button" value="注册" onclick="javascript:window.parent.body.location.href='${pageContext.request.contextPath }/client/register.jsp'">
	</form>
	</c:if>
	<c:if test="${not empty user }">
			欢迎${user.username }登录&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath }/client/UserServlet?operation=cancel">注销</a><br/>
		<a href="javascript:showIndex()">首页</a>
		<a href="javascript:showcart()">查看购物车</a>
		<a href="javascript:showOrder()">查看订单</a>
	</c:if>
</body>
<script type="text/javascript">
	function showOrder(){
		window.parent.body.location.href="${pageContext.request.contextPath }/client/showOrderServlet?operation=showOrder";
	}
	function showcart(){
		window.parent.body.location.href="${pageContext.request.contextPath}/client/listcart.jsp";
	}
	function showIndex(){
		window.parent.body.location.href="${pageContext.request.contextPath}/client/WelcomeServlet";
	}
</script>
</html>