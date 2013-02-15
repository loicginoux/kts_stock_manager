KTS.lessons.edit = KTS.lessons.new = function() {

	// just date picker stuff
	$('input.datepicker').datepicker( "option", "dateFormat","dd/mm/yy" );

	// select2 stuff
	$("#lesson_instructor_id").select2({ width: 'resolve' });
	if($("form#edit_lesson").length){
		$("#lesson_contracts_input .inline-hints").html("Students can't be edited. For changes please delete this lesson and create a new one.")
		$("#lesson_contract_ids").select2({
			width: 'resolve'
		});
		$("#lesson_contract_ids").select2("disable")
	}else{
		$("#lesson_contract_ids").select2({
			width: 'resolve',
			placeholder: "Search for students..."
		});
	}




};
