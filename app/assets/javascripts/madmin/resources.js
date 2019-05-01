// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var updateResourceOptions = function(polymorphicField) {
  var idField = document.getElementById("commentable_id");
  var slug =
    polymorphicField.options[polymorphicField.selectedIndex].dataset.slug;

  idField.options.length = 0;

  if (!slug) {
    idField.classList.add("d-none");
    return;
  }

  axios.get("/madmin/" + slug + ".json").then(function(response) {
    response.data.forEach(function(resource) {
      var option = document.createElement("option");
      option.text = resource.display_value;
      option.value = resource.id;
      idField.add(option);
    });

    idField.classList.remove("d-none");
  });
};

if (window.polymorphicFields) {
  window.polymorphicFields.forEach(function(field) {
    var polymorphicField = document.getElementById(field + "_type");

    polymorphicField.addEventListener("change", function() {
      updateResourceOptions(polymorphicField);
    });
  });
}
