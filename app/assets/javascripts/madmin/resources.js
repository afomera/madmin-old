// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.polymorphicFields.forEach(function(field) {
  var polymorphicField = document.getElementById(field + "_type");

  polymorphicField.addEventListener("change", function() {
    var idField = document.getElementById("commentable_id");

    idField.options.length = 0;

    axios
      .get(
        "/madmin/" +
          polymorphicField.options[polymorphicField.selectedIndex].dataset
            .slug +
          ".json"
      )
      .then(function(response) {
        response.data.forEach(function(resource) {
          var option = document.createElement("option");
          option.text = resource.display_value;
          option.value = resource.id;
          idField.add(option);
        });

        idField.classList.remove("d-none");
      });
  });
});
