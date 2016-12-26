<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="jquery-1.8.3.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=64bcbc1f41306136dd48eb21315300c1"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  </head>
  
  <body>
  <div id="map" style="width:80%;height:80%"></div>
  <input type="button" value="确定" id="" />
  </body>
</html>

<script type="text/javascript">
	$(document).ready(function(){
		var arr = [];
		var tileLayer = new BMap.TileLayer();
		tileLayer.getTilesUrl = function(tileCoord, zoom) {
		    var x = tileCoord.x;
		    var y = tileCoord.y;
		    return 'tiles/' + zoom + '/tile' + x + '_' + y + '.png';
		}
		var MyMap = new BMap.MapType('MyMap', tileLayer, {minZoom: 1, maxZoom: 5});
		var map = new BMap.Map('map', {mapType: MyMap});
		map.addControl(new BMap.NavigationControl());
		map.centerAndZoom(new BMap.Point(116.416648, 39.915886), 3);
// 		window.setTimeout(function(){
// 			var newpoint = new BMap.Point(116.669, 39.98);
// 			map.panTo(newpoint);
// 		},3000);
		
		map.addEventListener('click',function(e){
				var p = e.point;
				arr.push(p);
				var marker = new BMap.Marker(e.point);
				map.addOverlay(marker);
				var polyline = new BMap.Polyline(arr, {strokeColor:'blue',strokeWeight:6,strokeOpacity:0.5});
				map.addOverlay(polyline);
				map.centerAndZoom(e.point,map.getZoom());
			}
		);
		
		});
</script>
