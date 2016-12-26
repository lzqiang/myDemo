<%@ page contentType="text/html; charset=utf-8" import="org.g4studio.core.web.SessionContainer,org.g4studio.system.common.dao.vo.UserInfoVo"%>
<%
	//获取登录用户信息
	SessionContainer sc = (SessionContainer) request.getSession().getAttribute("SessionContainer");
	UserInfoVo userInfo = sc.getUserInfo();
	//查看公司id是否0
	String companyid=userInfo.getCompanyid();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <c:set var="ctx" value="${pageContext.request.contextPath}" scope="application"></c:set>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />     
    <title>Google Maps JavaSCRIPT API Example</title>
	    <style type="text/css">               
	      html { height: 100% }
	      body { height: 100%; margin: 0; padding: 0 }
	      #map_canvas { height: 100% }
	    </style>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBNkdtKPzQHQUjSSIGryyv_WVENW-mtMHM&sensor=true"></script>
    <script language="JavaScript" src="${ctx}/js/MapGoogle.js"></script>
  </head>
  <!--为了确保我们的地图仅放在完全加载的页面上，我们仅在HTML页面的<BODY> 元素收到onload事件后才执行构造GMap2对象的函数
      GUnload（） 函数是用来防止内存泄露的使用工具函数
    -->
  <body onload="initialize()">
    <div id="map_canvas" style="width:100%; height:100%"></div>
  </body>
</html>