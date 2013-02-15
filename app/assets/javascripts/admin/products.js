KTS.products.edit = KTS.products.new = function() {

    $("#product_brand_id").select2({ width: 'resolve' });
    $("#product_distributor_id").select2({ width: 'resolve' });
    $("#product_category_ids").select2({ width: 'resolve' });
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
};
