jQuery(document).ready(function($) {
		// autocomplete for product name filter
		$( ".index.admin_products #q_name" ).autocomplete({
      source: function( request, response ) {
        $.ajax({
          url: "/admin/products/autocomplete_name.json",
          dataType: "json",
          data: {
            term: request.term
          },
          success: function( data ) {
            response( $.map( data, function( item ) {
              return {
                label: item.name,
                value: item.name
              };
            }));
          }
        });
      },
      minLength: 2
    });
});
