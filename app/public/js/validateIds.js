function validateIds(){
var idValue = $('#availabledate_id').val();
var b = idValue.split(',').map(function(item) {
  return parseInt(item, 10);
});
if (isNaN(b[0])){
  alert("Dates invalid");
  return false;
}
else if (b.length === 1){
  alert("Dates invalid");
  return false;
}
else if (b[0] === b[1]) {
  console.log(b);
  alert("Dates invalid");
  return false;
}
else {
  $('#availabledate_id').val(b);
  return true;}
}
