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

window.onload = function(){
		
	
	$("#checkname").blur(function(){
		var xmlHttp=ajaxFunction();
		xmlHttp.onreadystatechange = function(){
			if (xmlHttp.readyState == 4) {
				if (xmlHttp.status == 200 || xmlHttp.status == 304) {
					var data = xmlHttp.responseText;
					var jsonData = eval("(" + data + ")");					
					for (var i = 0; i < jsonData.length; i++) {
						var data=jsonData[i].name;
						if(data==undefined){
							document.getElementById("spanIdName").innerHTML +="" ;
						}else{
							document.getElementById("spanIdName").innerHTML +=data ;
						}
					}
				}
			}
		}
		xmlHttp.open("post","../addBookAjaxServlet",true);
		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		var postContent = Util.serializeForm(document.f);
		xmlHttp.send(postContent);
	});
	
	document.getElementById("checkprice").onblur=function(){		
//		var price=$("#checkprice").val();
		var xmlHttp=ajaxFunction();
		xmlHttp.onreadystatechange=function(){
			if(xmlHttp.readyState==4){
				if(xmlHttp.status==200 || xmlHttp.status==304){
					var data=xmlHttp.responseText;
					var jsonData=eval("("+data+")");
					for(var i=0;i<jsonData.length;i++){	
						var data=jsonData[i].price;
						if(data==undefined){
							 document.getElementById("spanId").innerHTML+="";
						}else{
					   		 document.getElementById("spanId").innerHTML+=data;
						}
					}
				}
			}
		}
		xmlHttp.open("post","../addBookAjaxServlet",true);
		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		var postContent = Util.serializeForm(document.f);
		xmlHttp.send(postContent);
	}
}