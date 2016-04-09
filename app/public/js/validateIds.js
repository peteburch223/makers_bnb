function validateIds(){
var idValue = $('#availabledate_id').val();
var b = idValue.split(',').map(function(item) {
  return parseInt(item, 10);
});

if (b.length > 1) {
  var range = [];
  var unavailable;
  for (var i = b[0]; i <= b[1]; i++) {
      range.push(i);
  }
  unavailable = findUnavailableIds();
  for (var x = 0; x < range.length; x++) {
    if ($.inArray(range[x], unavailable) != -1 ) {
      bootbox.alert("You have selected unavailable dates");
      return false;
    }
  }
}

if (isNaN(b[0])){
  bootbox.alert("Please select a date");
  return false;
}
else if (b.length === 1){
  bootbox.alert("Please select a check out date");
  return false;
}
else if (b[0] === b[1]) {
  bootbox.alert("Check in and check out dates must be different");
  return false;
}
else {
  $('#availabledate_id').val(b);
  return true;}
}
