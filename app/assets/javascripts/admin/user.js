KTS.users.index =  function() {


  var selectSettings = {
    allowClear: true,
    width: 'resolve',
    placeholder: "Search a user...",
    minimumInputLength: 2,
    ajax: {
        url:  "/admin/users/autocomplete_name.json",
        dataType: 'json',
        data: function (term, page) {
            return {
                term: term // search term
                // page_limit: 10
            };
        },
        results: function (data, page) {
            for (var i = data.length - 1; i >= 0; i--) {
              var user = data[i];
              user.text = user.first_name +" "+ user.last_name;
            }
            return {results: data};
        }
    },
    initSelection: function(element, callback) {
        // the input tag has a value attribute preloaded that points to a preselected movie's id
        // this function resolves that id attribute to an object that select2 can render
        // using its formatResult renderer - that way the movie name is shown preselected
        var id=$(element).val();
        if (id!=="") {
            var tr = $("#user_"+id)
            var text = tr.find("td.first_name").html() + " " + tr.find("td.last_name").html()
        }
        console.log("text:",text)
        callback({id:id, text:text})
    },
  };

  // attach autocomplete on existing transaction for edit form
  $(".filter_form #q_client").select2(selectSettings)

  // // set default val
  // var defaultVal = ($(".filter_form #q_client")).val()
  // if (defaultVal){
  //   $(".filter_form #q_client").select2("data", {id:defaultVal, text:"test"})
  // }

  // clear filter
  $(".clear_filters_btn").click(function(){
    $(".filter_form #q_client").select2("val", "")
    // $(".filter_form #q_client").select2("data", {id: null, text: null})
  })
};