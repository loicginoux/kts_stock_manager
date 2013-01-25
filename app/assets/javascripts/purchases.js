jQuery(document).ready(function($) {
  // delete message box
  $(".admin_purchases .delete_link, .admin_purchases .action_items a[data-method='delete']").attr("data-confirm", "Warning: Deleting a purchase will put the products sold back into the stock. Are you sure you want to do that?");

  // attach autocomplete on existing transaction for edit form
  $(".edit.admin_purchases .has_many_fields .product").autocomplete({
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
      // update hint for product
      $(event.target).attr("data_unit_price",ui.item.selling_price ).parent().find(".inline-hints").html("Product name: "+ui.item.label + " - unit price: "+ ui.item.selling_price);
      // update total price depending on quantity and unit price
      var has_many_fields = $(event.target).parents(".has_many_fields");
      var quantity = has_many_fields.find(".quantity").val();
      var unit_price = ui.item.selling_price;
      if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
        has_many_fields.find(".total_price").val(quantity*unit_price);
        $("#purchase_price").trigger("update");
      }
    }
  });

  $(".edit.admin_purchases .has_many_fields .quantity").change(function(e){
    var has_many_fields = $(e.target).parents(".has_many_fields");
    var quantity = $(e.target).val();
    var unit_price = has_many_fields.find(".product").attr("data_unit_price");
    if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
      has_many_fields.find(".total_price").val(quantity*unit_price);
      $("#purchase_price").trigger("update");
    }
  });

  $(".admin_purchases .has_many_fields .total_price").change(function(e){
    $("#purchase_price").trigger("update");
  });

  // when clicking on "add new transaction"
  $(".admin_purchases .has_many").children(":last").click(function(){
    // we attach the autocomplete for each transaction
    $(".admin_purchases .has_many_fields:last .product").autocomplete({
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
        // update hint for product
        $(event.target).attr("data_unit_price",ui.item.selling_price ).parent().find(".inline-hints").html("Product name: "+ui.item.label + " - unit price: "+ ui.item.selling_price);
        // update total price depending on quantity and unit price
        var has_many_fields = $(event.target).parents(".has_many_fields");
        var quantity = has_many_fields.find(".quantity").val();
        var unit_price = ui.item.selling_price;
        if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
          has_many_fields.find(".total_price").val(quantity*unit_price);
          $("#purchase_price").trigger("update");
        }
      }
    });


    // on form, when changing quantity, we update the total price
    $(".admin_purchases .has_many_fields:last .quantity").change(function(e){
      var has_many_fields = $(e.target).parents(".has_many_fields");
      var quantity = $(e.target).val();
      var unit_price = has_many_fields.find(".product").attr("data_unit_price");
      if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
        has_many_fields.find(".total_price").val(quantity*unit_price);
        $("#purchase_price").trigger("update");
      }
    });

    $(".admin_purchases .has_many_fields:last .total_price").change(function(e){
      $("#purchase_price").trigger("update");
    });
  });


$("#purchase_price").on("update", function(){
  var tot = 0;
  $(".total_price").map(function(i, tr){
    tot += parseInt(tr.value);
  });
  this.value = tot;
});


});
