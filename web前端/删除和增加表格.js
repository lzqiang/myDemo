// JavaScript Document
function add(){
	var tb1=document.getElementsByTagName("table")[0];
	var tr1=document.createElement("tr");
	var td1=document.createElement("td");
	td1.innerHTML="张三";
	var td2=document.createElement("td");
	td2.innerHTML="男";
	var td3=document.createElement("td");
	td3.innerHTML="29";
	tr1.appendChild(td1);
	tr1.appendChild(td2);
	tr1.appendChild(td3);
	tb1.appendChild(tr1);
	}
function del(){
	//var tb=document.getElementsByTagName("table");
	var tr=document.getElementsByTagName("tr");
	removeChild(tr);
	
	
	}