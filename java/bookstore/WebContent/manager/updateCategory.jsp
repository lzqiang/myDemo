<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改页面</title>
</head>
<body>
	<form action="${pageContext.request.contextPath }/manager/categoryServlet?operation=updateSave" method="post">
	分类名称：<input type="text" name="categoryName" value="${category.name }"><br/>
	分类描述：<textarea rows="5" cols="50" name="description">${category.description }</textarea><br/>
	<input type="hidden" name="id" value="${category.id }"/>
	<input type="submit" value="修改"/>
	<input type="reset" value="取消">
	</form>
</body>
</html>