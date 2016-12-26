<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<title>多个标注点沿折线的轨迹运动</title>
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
var tileLayer = new BMap.TileLayer();
tileLayer.getTilesUrl = function(tileCoord, zoom) {
    var x = tileCoord.x;
    var y = tileCoord.y;
    return 'tiles/' + zoom + '/tile' + x + '_' + y + '.png';
}
var MyMap = new BMap.MapType('MyMap', tileLayer, {minZoom: 1, maxZoom: 13});


// 百度地图API功能
var map = new BMap.Map("allmap");
map.setMapType(MyMap);
// map.centerAndZoom(new BMap.Point(116.404, 39.915), 15);
map.enableScrollWheelZoom();
map.addControl(new BMap.NavigationControl());
map.addControl(new BMap.MapTypeControl());
map.addControl(new BMap.ScaleControl());
map.disableDoubleClickZoom();
map.addControl(new BMap.OverviewMapControl());

map.centerAndZoom(new BMap.Point(117.36936, 31.815826), 13);
var bounds = null;
var linesPoints = null;
var spoi1 = new BMap.Point(117.380967,31.913285);    // 起点1
var spoi2 = new BMap.Point(117.380967,31.953285);    // 起点2
var epoi  = new BMap.Point(117.424374,31.914668);    // 终点
var myIcon = new BMap.Icon("man.png", new BMap.Size(32, 70), {imageOffset: new BMap.Size(0, 0)});
var myIcon2 = new BMap.Icon("female.png", new BMap.Size(32, 70), {imageOffset: new BMap.Size(0, 0)});

function initLine(){
    bounds = new Array();
    linesPoints = new Array();
    map.clearOverlays();                                                    // 清空覆盖物
    var driving3 = new BMap.DrivingRoute(map,{onSearchComplete:drawLine});  // 驾车实例,并设置回调
        driving3.search(spoi1, epoi);                                       // 搜索一条线路
    var driving4 = new BMap.DrivingRoute(map,{onSearchComplete:drawLine});  // 驾车实例,并设置回调
        driving4.search(spoi2, epoi);                                       // 搜索一条线路
}

function run(){
    for(var m = 0;m < linesPoints.length; m++){
        var pts = linesPoints[m];
        var len = pts.length;
        var icon = myIcon;
        if(m%linesPoints.length>0) {
        	icon=myIcon2;
        }
        var carMk = new BMap.Marker(pts[0],{icon:icon});
        map.addOverlay(carMk);
        resetMkPoint(1,len,pts,carMk)
    }
    
    function resetMkPoint(i,len,pts,carMk){
        carMk.setPosition(pts[i]);
        if(i < len){
            setTimeout(function(){
                i++;
                resetMkPoint(i,len,pts,carMk);
            },100);
        }
    }
    
}

function drawLine(results){
    var opacity = 0.8;
    var planObj = results.getPlan(0);
    var b = new Array();
    var addMarkerFun = function(point,imgType,index,title){
        var url;
        var width;
        var height
        var myIcon;
        // imgType:1的场合，为起点和终点的图；2的场合为车的图形
        if(imgType == 1){
            url = "man.png";
            width = 32;
            height = 32;
            myIcon = new BMap.Icon(url,new BMap.Size(width, height),{offset: new BMap.Size(14, 32),imageOffset: new BMap.Size(0, 0 - index * height)});
        }else{
            url = "female.png";
            width = 22;
            height = 25;
            var d = 25;
            var cha = 0;
            var jia = 0
            if(index == 2){
                d = 21;
                cha = 5;
                jia = 1;
            }
            myIcon = new BMap.Icon(url,new BMap.Size(width, d),{offset: new BMap.Size(10, (11 + jia)),imageOffset: new BMap.Size(0, 0 - index * height - cha)});
        }
        
        var marker = new BMap.Marker(point, {icon: myIcon});
        if(title != null && title != ""){
            marker.setTitle(title);
        }
        // 起点和终点放在最上面
        if(imgType == 1){
            marker.setTop(true);
        }
        map.addOverlay(marker);
    }
    var addPoints = function(points){
        for(var i = 0; i < points.length; i++){
            bounds.push(points[i]);
            b.push(points[i]);
        }
    }
    
    // 绘制驾车步行线路
    for (var i = 0; i < planObj.getNumRoutes(); i ++){
        var route = planObj.getRoute(i);
        if (route.getDistance(false) <= 0){continue;}
        addPoints(route.getPath());
        // 驾车线路
        if(route.getRouteType() == BMAP_ROUTE_TYPE_DRIVING){
            map.addOverlay(new BMap.Polyline(route.getPath(), {strokeColor: "#0030ff",strokeOpacity:opacity,strokeWeight:3,enableMassClear:true}));
        }else{
        // 步行线路有可能为0
            map.addOverlay(new BMap.Polyline(route.getPath(), {strokeColor: "#30a208",strokeOpacity:0.9,strokeWeight:2,enableMassClear:true}));
        }
    }
    
    map.setViewport(bounds);
    
    // 终点
    addMarkerFun(results.getEnd().point,1,1);
    // 开始点
    addMarkerFun(results.getStart().point,1,0);
    linesPoints[linesPoints.length] = b;
}

initLine();

setTimeout(function(){
    run();
},3000);
</script>
