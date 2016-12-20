function ajaxFunction(){
    var xmlHttp;
    try { // Firefox, Opera 8.0+, Safari
        xmlHttp = new XMLHttpRequest();
    } 
    catch (e) {
        try {// Internet Explorer
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        } 
        catch (e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } 
            catch (e) {
            }
        }
    }
    return xmlHttp;
}
window.onload=function(){
	$("#username").blur(function(){
	var xmlHttp=ajaxFunction();
	xmlHttp.onreadystatechange=function(){
		if(xmlHttp.readyState==4){
			if(xmlHttp.status==200 || xmlHttp.status==304){
				var date=xmlHttp.responseText;
				alert(date);
			}
		}
	}
	xmlHttp.open("post","../client/ajaxServlet",true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	var $path=$("#form").serialize(); 
	alert($path);
	xmlHttp.send($path);
	});
	
}
