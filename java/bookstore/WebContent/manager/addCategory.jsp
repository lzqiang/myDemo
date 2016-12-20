<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath }/CSS/css/screen.css" />
<script src="${pageContext.request.contextPath }/CSS/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/CSS/jquery.validate.js" type="text/javascript"></script>

</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#form").validate({
				rules:{
					categoryName:"required",
					description:"required"
				},
				messages:{
					categoryName:"分类名称不能为空",
					description:"分类描述不能为空"
				}
			});
		})
		
	</script>
	<form id="form" action="${pageContext.request.contextPath }/manager/categoryServlet?operation=addCategory" method="post">
	分类名称：<input type="text" name="categoryName"><br/>
	分类描述：<textarea rows="5" cols="50" name="description"></textarea><br/>
	<input type="submit" value="添加"/>
	<input type="reset" value="取消">
	</form>
</body>
</html>