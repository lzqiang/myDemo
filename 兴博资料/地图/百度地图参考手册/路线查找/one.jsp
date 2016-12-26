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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=64bcbc1f41306136dd48eb21315300c1"></script>
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
map.centerAndZoom(new BMap.Point(116.404, 39.915), 15);
var myP1 = new BMap.Point(116.380967,39.913285);    //起点
var myP2 = new BMap.Point(116.424374,39.914668);    //终点
var myIcon = new BMap.Icon("head.png", new BMap.Size(32, 70), {    //小车图片
    //offset: new BMap.Size(0, -5),    //相当于CSS精灵
    imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });
var driving2 = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});    //驾车实例
driving2.search(myP1, myP2);    //显示一条公交线路

window.run = function (){
    var driving = new BMap.DrivingRoute(map);    //驾车实例
    driving.search(myP1, myP2);
    driving.setSearchCompleteCallback(function(){
        var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组
        var paths = pts.length;    //获得有几个点

        var carMk = new BMap.Marker(pts[0],{icon:myIcon});
        map.addOverlay(carMk);
        i=0;
        function resetMkPoint(i){
            carMk.setPosition(pts[i]);
            if(i < paths){
                setTimeout(function(){
                    i++;
                    resetMkPoint(i);
                },100);
            }
        }
        setTimeout(function(){
            resetMkPoint(5);
        },500)

    });
}

setTimeout(function(){
    run();
},3000);
</script>
