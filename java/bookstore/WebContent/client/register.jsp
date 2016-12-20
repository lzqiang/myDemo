<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/table.css">
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath }/CSS/css/screen.css" />
<script src="${pageContext.request.contextPath }/CSS/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/CSS/jquery.validate.js" type="text/javascript"></script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#form").validate({
				rules:{
					username:{
						required:true,
						minlength:2,
						maxlength:10						
					},
					password:{
						required:true,
						minlength:5,
						maxlength:15
					},
					newpassword:{
						equalTo:"#password"
					},
					cellphone:{
						required:true,
						digits:true
					},
					address:{
						required:true
					},
					email:{
						required:true,
						email:true
					},
					code:{
						required:true,
						digits:true		
					}
				},
				messages:{
					username:{
						required:"用户名不能为空",
						minlength:"用户名长度最小不能少于2个字符",
						maxlength:"用户名长度最大不能超过10个字符"					
					},
					password:{
						required:"密码不能为空",
						minlength:"密码长度最小不能少于5",
						maxlength:"密码长度最大不能超过15"
					},
					newpassword:{
						equalTo:"两次密码输入不相同"
					},
					cellphone:{
						required:"电话号码不能为空",
						digits:"请输入正确的号码"
					},
					address:{
						required:"请填写地址"
					},
					email:{
						required:"电子邮箱不能为空",
						email:"电子邮箱格式错误"
					},
					code:{
						required:"请天下验证码",
						digits:"验证码格式错误"					
					}
				}
			});
		})
	</script>
	<center>
	<h3>用户注册</h3>
	<form id="form" action="${pageContext.request.contextPath }/client/UserServlet?operation=register" method="post">
	<table >
		<tr>
			<td>用户名</td>
			<td><input type="text" name="username" id="username"/><span id="username"></span></td>
		</tr>
		<tr>
			<td>密码</td>
			<td><input type="password" id="password" name="password"/></td>
		</tr>
		<tr>
			<td>确认密码</td>
			<td><input type="password" id="newpassword" name="newpassword"/></td>
		</tr>
		<tr>
			<td>手机</td>
			<td><input type="text" name="cellphone"/></td>
		</tr>
		<tr>
			<td>住址</td>
			<td><input type="text" name="address"/></td>
		</tr>
		<tr>
			<td>邮箱</td>
			<td><input type="text" name="email"/></td>
		</tr>
		<tr>
			<td>验证码</td>
			<td><input type="text" name="code"><img id="imm" alt="验证码" src="${pageContext.request.contextPath }/CheckCode"/>
			<a href="javascript:void(0)" onclick="change()">看不清,换一张</a>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="注册"/>
				<input type="reset" value="取消"/>
			</td>
		</tr>
		</table>		
	</form>
	</center>
	<script type="text/javascript">
		function change(){
			var imgObj=document.getElementById("imm");
			imgObj.src=imgObj.src+"?"+new Date().getTime();
		}
	</script>
</body>
</html>