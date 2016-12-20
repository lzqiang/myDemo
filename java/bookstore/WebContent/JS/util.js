var Util = {};
Util.serializeForm = function(form) {
	var postContent = "";
	var elements = form.elements;
	for ( var i = 0; i < elements.length;i++) {
		var element = elements[i];
		if (element.name == "") {
			continue;
		}
		if (element.type == "text" || element.type == "textarea"
				|| element.type == "hidden") {
			postContent += element.name + "="
				+ element.value + "&";
			continue;
		}

		if (element.type == "select-one" || element.type == "select-multiple") {
			var options = element.options, j, item;
			for (j = 0; j < options.length; ++j) {
				item = options[j];
				if (item.selected) {
					postContent += element.name + "="
				+ element.value + "&";
				}
			}
			continue;
		}

		if (element.type == "checkbox" || element.type == "radio") {
			if (element.checked) {
				postContent += element.name + "="
				+ element.value + "&";
			}
			continue;
		}

		if (element.type == "file") {
			if (element.value != "") {
				postContent += element.name + "="
				+ element.value + "&";
			}
			continue;
		}
		postContent += element.name + "="
				+ element.value + "&";

	}
	return postContent;
};