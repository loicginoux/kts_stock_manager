jQuery(document).ready(function($) {
  // update total price depending on quantity and unit price
  var updateTotalPrice = function(){
    var quantity = $("#transaction_quantity").val();
    var unit_price = $("#transaction_product_id_input .inline-hints").attr("data-unit-price");
    if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
      $("#transaction_total_price").val(quantity*unit_price);
    }
  };

	//  autocomplete for product name on transaction form
  $(".admin_transactions #transaction_product_id").autocomplete({
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
              value: item.id,
              selling_price: item.selling_price
            };
          }));
        }
      });
    },
    minLength: 2,
    select: function( event, ui ) {
      $(event.target).parent().find(".inline-hints").html("Product name: "+ui.item.label + " - unit price: "+ ui.item.selling_price).attr("data-unit-price",ui.item.selling_price );
      updateTotalPrice();
    }
  });

  // on form, when changing quantity, we update the total price
  $(".admin_transactions #transaction_quantity").change(updateTotalPrice);



});
