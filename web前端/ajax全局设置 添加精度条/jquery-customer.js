//设置AJAX的全局默认选项
/*
 * ajax中已设置global默认为true，提交时若想出现进度提示 将global设置为true，或者去除global设置。 若不想出现进度提示则将global设置为false
 */
$.ajaxSetup({
	cache : false,
	global: true
});

var jdIndexArray=new Array();
$(document).ajaxSend(function() {
	var i=window.top.layer.load();
	jdIndexArray.push(i);
});

$(document).ajaxSuccess(function(){
	var i=jdIndexArray.pop();
	window.top.layer.close(i);
});

$(document).ajaxError(function(){
	var i=jdIndexArray.pop();
	window.top.layer.close(i);
});

