<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath }/CSS/css/screen.css" />
<script src="${pageContext.request.contextPath }/CSS/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/CSS/jquery.validate.js" type="text/javascript"></script>
<title>添加图书</title>
</head>
<body>
	<script type="text/javascript">
		//自定义方法
		$.validator.addMethod("images",function(value,element,params){
			var value=value.substring(value.lastIndexOf(".")+1);
			if(value=="jpg"||value=="bmp" || value=="png"){
				return true;
			}
			return false;
		});
		$(document).ready(function(){
			$("#f").validate({
				rules:{
					name:"required",
					author:"required",
					price:{
						required:true,
						number:true
					},
					description:"required",
					images:{
						required:true,
						images:"images"
					}
				},
				messages:{
					name:"图书名不能为空",
					author:"作者姓名不能为空",
					price:{
						required:"价格不能为空",
						number:"请输入合法的数字"
					},
					description:"写点描述吧",
					images:{
						required:"请上传图片",
						images:"格式错误！！"
					}
				
				}
			});
		});
	</script>
	<form id="f" action="${pageContext.request.contextPath }/manager/BookServlet?operation=addBookSave" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>图书名称</td>
			<td><input type="text" name="name" id="checkname"/><span id="spanIdName"></span></td>
		</tr>
		<tr>
			<td>作者</td>
			<td><input type="text" name="author" id="checkauthor"/></td>
		</tr>
		<tr>
			<td>价钱</td>
			<td><input type="text" name="price" id="checkprice"/><span id="spanId"></span></td>
		</tr>
		<tr>
			<td>图片</td>
			<td><input type="file" name="images"/></td>
		</tr>
		<tr>
			<td>描述</td>
			<td><textarea rows="5" cols="50" name="description" id="checkdescription"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<select name="category">
					<c:forEach items="${Categorys }" var="book">
						<option value="${book.id }">${book.name }</option>						
					</c:forEach>	
				</select>			
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="添加">
				<input type="reset" value="取消">
			</td>
		</tr>
		</table>
	</form>
</body>
</html>