<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>显示图书列表</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/table.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/JS/js.js"></script>
</head>
<body>
<center>
	<h2>图书列表</h2>
	<table>
		<tr>
			<th>序号</th>
			<th>书名</th>
    		<th>作者</th>
    		<th>价格</th>
    		<th>描述</th>
    		<th>图片</th>
    		<th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="book" varStatus="stat">
			<tr>
				<td>${stat.count }</td>
				<td>${book.name }</td>
				<td>${book.author }</td>
				<td>${book.price }</td>
				<c:choose>
					<c:when test="${fn:length(book.description)>6}">
						<td title="${book.description }">${fn:substring(book.description,0,6) }...</td>
					</c:when>
					<c:otherwise>
						<td>${book.description }</td>
					</c:otherwise>
				</c:choose>
				<td><a href="${pageContext.request.contextPath }/manager/BookServlet?operation=showImage&imageName=${book.images}">查看图片</a></td>
				<td>
					<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=updateBook&bookid=${book.id}">修改</a>
					<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=deleteBook&bookid=${book.id}">删除</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	共有${page.totalrecord }记录&nbsp;&nbsp;${page.pageNum }/${page.totalpage }&nbsp;&nbsp;
<%-- 	<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks&pageNum=1">首页</a> --%>
	<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks&pageNum=${page.pageNum-1>0? page.pageNum-1:1}">上一页</a>
	<c:if test="${page.startpage!=1 }">
		<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks&pageNum=1">1</a>...			
	</c:if>
	
	<c:forEach begin="${page.startpage }" end="${page.endpage }" var="pageNum">		
		[<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks&pageNum=${pageNum}">${pageNum }</a>]
	</c:forEach>
	<c:if test="${page.endpage!=page.totalpage}">
		...<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks&pageNum=${page.totalpage}">${page.totalpage }</a>
	</c:if>
	<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks&pageNum=${page.pageNum+1>=page.totalpage? page.totalpage:page.pageNum+1}">下一页</a>
<%-- 	<a href="${pageContext.request.contextPath }/manager/BookServlet?operation=ListBooks&pageNum=${page.totalpage}">末页</a> --%>
	
	</center>
</body>

</html>