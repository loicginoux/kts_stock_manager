KTS.bills.edit = KTS.bills.new = function(){


  var formatSelectionProducts = function(prod, container){
    return prod.name + " ("+prod.selling_price+"€)";
  }
  var formatProducts = function(prod){
    var el = "<p><b>"+prod.name +" </b></br>"+
    "<label>price: "+prod.selling_price+"€"
    if (prod.brands){ el += " - brand: "+prod.brands}
    if (prod.size){ el += " - size: "+prod.size}
    if (prod.color){ el += " - color: "+prod.color}
    if (prod.year){ el += " - year: "+prod.year}
    if (prod.year){ el += " - quantity: "+prod.quantity}
    el += "</label></p>"
    return el;
  };

  var quantityProductChange = function(e){
    var has_many_fields = $(e.target).parents(".has_many_fields");
    var quantity = $(e.target).val();
    var unit_price = has_many_fields.find(".product").select2("data").selling_price;
    if (quantity && unit_price && !isNaN(quantity) && !isNaN(unit_price)) {
      has_many_fields.find(".total_price").val(quantity*unit_price);
      triggerUpdatePrice()
    }
  }

  var triggerUpdatePrice = function(){
    $("#bill_price").trigger("update");
  }
  var selectProductChange = function(e) {
    targ = $(e.target)
    data = targ.select2("data")
    var unit_price = data.selling_price
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
    formatResult: formatProducts,
    formatSelection: formatSelectionProducts,
    escapeMarkup: function(m) { return m; }
  };


  // delete message box
  $(".admin_bills .delete_link, .admin_bills .action_items a[data-method='delete']").attr("data-confirm", "Warning: Deleting a bill will put the products sold back into the stock. Are you sure you want to do that?");

  // attach autocomplete on existing new product transaction for edit form
  $(".edit.admin_bills .has_many_fields .product").select2(selectSettings).on("change", selectProductChange);

  // when quantity change we change price
  $(".edit.admin_bills .has_many_fields .quantity").change(quantityProductChange);

  // when transaction total price changes we update bill price
  $(".admin_bills .has_many_fields .total_price").change(triggerUpdatePrice);

  // when clicking on "add new transaction"
  $(".admin_bills .has_many a").click(function(){
    // we attach the select2 for each transaction
    $(".admin_bills .has_many_fields:last .product").select2(selectSettings).on("change", selectProductChange);

    // on form, when changing quantity, we update the total price
    $(".admin_bills .has_many_fields:last .quantity").change(quantityProductChange);

    $(".admin_bills .has_many_fields:last .total_price").change(triggerUpdatePrice);
  });


  $("#bill_price").on("update", function(){
    var tot = 0;
    $(".total_price").map(function(i, tr){
      tot += parseInt(tr.value);
    });
    this.value = tot;
  });


};