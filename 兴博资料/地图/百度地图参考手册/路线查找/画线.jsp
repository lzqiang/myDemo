<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<style type="text/css">
	body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
	</style>
    <script type="text/javascript" src="jquery-1.8.3.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  </head>
  
  <body>
  <div id="allmap"></div>
  </body>
</html>

<script type="text/javascript">

// 百度地图API功能
var map = new BMap.Map("allmap");
map.centerAndZoom(new BMap.Point(116.404, 39.915), 13);
map.addControl(new BMap.NavigationControl({type: BMAP_NAVIGATION_CONTROL_SMALL}));
map.enableScrollWheelZoom();    

var pointarr=[
  new BMap.Point(116.399, 39.910),
  new BMap.Point(116.405, 39.920),
  new BMap.Point(116.415, 39.950),
  new BMap.Point(116.435, 39.910),
  new BMap.Point(116.425, 39.900),
  new BMap.Point(116.455, 39.860),
  new BMap.Point(116.435, 39.880),
  new BMap.Point(116.419, 39.830),
  new BMap.Point(116.400, 39.845)
];


var carMk="";
var myIcon = new BMap.Icon("./attendance/images/pepole_datu.png", new BMap.Size(33,33), {    //小车图片
    //offset: new BMap.Size(0, -5),    //相当于CSS精灵
    imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
});
carMk = new BMap.Marker(pointarr[0],{icon:myIcon});
map.addOverlay(carMk);
var mytimer=setInterval("dodraw()", 2000);
var i=1;
function dodraw(){
	if(i<pointarr.length){
		map.panTo(pointarr[i]);
		carMk.setPosition(pointarr[i]);
		var polyline = new BMap.Polyline([
		  pointarr[i-1],
		  pointarr[i]
		], {strokeColor:"blue", strokeWeight:6, strokeOpacity:0.5});
		map.addOverlay(polyline);
		i++;
	}else{
		if(mytimer!=""){
			clearInterval(mytimer);
		}
	}
}
</script>
