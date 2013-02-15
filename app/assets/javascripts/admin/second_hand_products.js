KTS.second_hand_products.edit = KTS.second_hand_products.new = function() {

	// select2 stuff
	$("#second_hand_product_category_ids").select2({
		width: 'resolve',
		placeholder: "Add Categories..."
	});
	$("#second_hand_product_brand_id").select2({
		width: 'resolve',
		placeholder: "Select Brand..."
	});
	$("#second_hand_product_user_id").select2({
		width: 'resolve',
		placeholder: "Select Client..."
	});

};