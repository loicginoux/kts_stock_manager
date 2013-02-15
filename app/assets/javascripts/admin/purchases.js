KTS.purchases.edit = KTS.purchases.new = function(){
  var formatSelectionProduct = function(prod, container){
    return prod.name + " ("+prod.cost_price+"€)";
  }

  var formatProduct = function(prod){
    var el = "<p><b>"+prod.name +" </b></br>"+
    "<label>cost price: "+prod.cost_price+"€"
    if (prod.brands){ el += " - brand: "+prod.brands}
    if (prod.size){ el += " - size: "+prod.size}
    if (prod.color){ el += " - color: "+prod.color}
    if (prod.year){ el += " - year: "+prod.year}
    if (prod.year){ el += " - quantity in stock: "+prod.quantity}
    el += "</label></p>"
    return el;
  };

  var quantityProductChange = function(e){
    var has_many_fields = $(e.target).parents(".has_many_fields");
    var quantity = $(e.target).val();
    var unit_price = has_many_fields.find(".product").select2("data").cost_price;
    if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
      has_many_fields.find(".total_price").val(quantity*unit_price);
      triggerUpdatePrice()
    }
  }

  var triggerUpdatePrice = function(){
    $("#purchase_price").trigger("update");
  }

  var selectProductChange = function(e) {
    targ = $(e.target)
    data = targ.select2("data")
    var unit_price = data.cost_price
    $(event.target).attr("data_unit_price",unit_price )
    //update total price depending on quantity and unit price
    var has_many_fields = $(event.target).parents(".has_many_fields");
    var quantity = has_many_fields.find(".quantity").val();
    if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
      has_many_fields.find(".total_price").val(quantity*unit_price);
      triggerUpdatePrice()
    }
  };

  var selectSettings = {
    width: 'resolve',
    placeholder: "Search for a product in stock",
    minimumInputLength: 2,
    ajax: {
        url:  "/admin/products/autocomplete_name.json",
        dataType: 'json',
        data: function (term, page) {
            return {
                term: term // search term
                // page_limit: 10
            };
        },
        results: function (data, page) {
            return {results: data};
        }
    },
    formatResult: formatProduct,
    formatSelection: formatSelectionProduct,
    escapeMarkup: function(m) { return m; }
  };

  jQuery(document).ready(function($) {
    // delete message box
    $(".admin_purchases .delete_link, .admin_purchases .action_items a[data-method='delete']")
    .attr("data-confirm", "Warning: Deleting a purchase will remove the products from the stock. Are you sure you want to do that?");

    // attach autocomplete on existing transaction for edit form
    $(".edit.admin_purchases .has_many_fields .product").select2(selectSettings).on("change", selectProductChange);

    $(".edit.admin_purchases .has_many_fields .quantity").change(quantityProductChange);


    $(".admin_purchases .has_many_fields .total_price").change(triggerUpdatePrice);


    // when clicking on "add new transaction"
    $(".admin_purchases .has_many").children(":last").click(function(){
      // we attach the autocomplete for each transaction
      $(".admin_purchases .has_many_fields:last .product").select2(selectSettings).on("change", selectProductChange);


      // on form, when changing quantity, we update the total price
      $(".admin_purchases .has_many_fields:last .quantity").change(quantityProductChange);

      $(".admin_purchases .has_many_fields:last .total_price").change(triggerUpdatePrice);

    });

    $("#purchase_price").on("update", function(){
      var tot = 0;
      $(".total_price").map(function(i, tr){
        tot += parseInt(tr.value);
      });
      this.value = tot;
    });


  });
};