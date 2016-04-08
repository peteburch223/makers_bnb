function validateIds(){
var idValue = $('#availabledate_id').val();
var b = idValue.split(',').map(function(item) {
  return parseInt(item, 10);
});
if (isNaN(b[0])){
  bootbox.alert("Please select a date");
  return false;
}
else if (b.length === 1){
  bootbox.alert("Please select a check out date");
  return false;
}
else if (b[0] === b[1]) {
  console.log(b);
  bootbox.alert("Check in and check out dates must be different");
  return false;
}
else {
  $('#availabledate_id').val(b);
  return true;}
}
