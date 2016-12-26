
 function initialize() {//初始化地图
        var mapOptions = {
          center: new google.maps.LatLng(31.867204,117.289686),//锚点坐标 设置中心位置 latLng设置缩放层级
          zoom: 13,//设置层级
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
        
         var image = '../images/car.gif';  
         var myLatLng = new google.maps.LatLng(31.867204,117.289686);  
         var beachMarker = new google.maps.Marker({  
           position: myLatLng,  
           map: map,  
           icon:image
        });     
}     
 