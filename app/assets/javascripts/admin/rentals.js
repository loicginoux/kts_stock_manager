KTS.rentals.edit = KTS.rentals.new = function() {

	// just date picker stuff
	$('input.datepicker').datepicker();
	$('input.datepicker').datepicker( "option", "dateFormat","dd/mm/yy" );

	// select2 stuff
	$("#rental_user_id").select2({ width: 'resolve' });
	$(".has_many_fields").find("select:first")
.select2({ width: 'resolve' });
	$(".borrows").children('a').click(function(){
		$(".has_many_fields:last select:first").select2({ width: 'resolve' });

	})


};
