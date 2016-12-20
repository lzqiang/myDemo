<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看分类</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/table.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/js.js"></script>

</head>
<body>
	<center>
	<c:choose>
	<c:when test="${not empty category }">
	<h2>图书分类</h2>
	<table>
		<tr>
			<th>序号</th>
			<th>分类名称</th>
			<th>分类描述</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${category}" var="c" varStatus="stat">
			<tr>
				<td>${stat.count }</td>
				<td>${c.name }</td>
				<td title="${c.description}">${fn:length(c.description)>8?fn:substring(c.description,0,8):c.description}...</td>
				<td>
					<a href="${pageContext.request.contextPath }/manager/categoryServlet?operation=update&id=${c.id}">修改</a>&nbsp;&nbsp;
					<a href="${pageContext.request.contextPath }/manager/categoryServlet?operation=delete&id=${c.id}">删除</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	</c:when>
		<c:otherwise>
			<h1>没有添加任何分类</h1>
		</c:otherwise>
	</c:choose>
	</center>
</body>
</html>