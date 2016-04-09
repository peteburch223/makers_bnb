var available_obj = gon.available_dates;
var dates = [];
var id = [];

var key;
for (key in available_obj) {
  if (available_obj.hasOwnProperty(key)) {
      available_obj[key] = available_obj[key].split('-').reverse().join('-');
  }
  dates.push(available_obj[key]);
}

function enableSpecificDates(date) {
  currentDate = parseDates(date);
  for (var i = 0; i < dates.length; i++) {
    if ($.inArray(currentDate, dates) != -1 ) {
      var check_in = $.datepicker.parseDate("dd-mm-yy", $("#check_in").val());
      var check_out = $.datepicker.parseDate("dd-mm-yy", $("#check_out").val());
      return [true, check_in && ((date.getTime() == check_in.getTime()) || (check_out && date >= check_in && date <= check_out)) ? "dp-highlight" : ""];
    } return [false];
  }
}

function parseDates(date){
  var m = date.getMonth() + 1;
  if (m < 10) { m = '0' + m; }
  var d = date.getDate();
  if (d < 10) { d = '0' + d; }
  var y = date.getFullYear();
  var currentDate = d + '-' + m + '-' + y;
  return currentDate;
}

$(".datepicker").datepicker({
  minDate: 0,
  numberOfMonths: [1,1],
  dateFormat: "dd-mm-yy",
  beforeShowDay: enableSpecificDates,
  onSelect: function(dateText, inst) {
      var check_in = $.datepicker.parseDate("dd-mm-yy", $("#check_in").val());
      var check_out = $.datepicker.parseDate("dd-mm-yy", $("#check_out").val());
      var selectedDate = $.datepicker.parseDate("dd-mm-yy", dateText);
console.log(dateText);
console.log(inst);
console.log(selectedDate);

      if (!check_in || check_out) {
          $("#check_in").val(dateText);
          $("#check_out").val("");
          id = [];
          updateIdInput('push');
      } else if( selectedDate < check_in ) {
          $("#check_out").val( $("#check_in").val() );
          $("#check_in").val(dateText);
          updateIdInput('unshift');
      } else {
          $("#check_out").val(dateText);
          updateIdInput('push');
      }

      function updateIdInput(method){
        if(method === 'push'){ id.push((_.invert(available_obj))[dateText]);}
        else { id.unshift((_.invert(available_obj))[dateText]); }
        $("#availabledate_id").val(id);
      }
  }
});
