KTS = {
	bills:{},
	contracts:{},
	lessons:{},
	products:{},
	purchases:{},
	rentals:{},
	second_hand_products:{},
	transactions:{},
	users:{}
}

jQuery(document).ready(function($) {
	var action,model, b = $("body");
	if (b.hasClass("edit")) {
		action = "edit";
	} else if(b.hasClass("view")){
		action = "view";
	} else if(b.hasClass("index")){
		action = "index"
	} else if(b.hasClass("new")){
		action = "new"
	}

	for (var m in KTS) {
		if (b.hasClass("admin_"+m)) {
			if (KTS[m][action] && typeof KTS[m][action] == "function") {
				KTS[m][action]();
				break;
			}
		}
	}
});