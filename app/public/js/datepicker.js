var available_obj = gon.available_dates;
var dates = [];
var id = [];

for (var key in available_obj) {
  dates.push(available_obj[key]);
}

function enableSpecificDates(date) {
  currentDate = parseDates(date);
  for (var i = 0; i < dates.length; i++) {
    if ($.inArray(currentDate, dates) != -1 ) {
      var check_in = $.datepicker.parseDate("yy-MM-dd", $("#check_in").val());
      var check_out = $.datepicker.parseDate("yy-MM-dd", $("#check_out").val());
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
  var currentDate = y + '-' + m + '-' + d;
  return currentDate;
}

$(".datepicker").datepicker({
  minDate: 0,
  numberOfMonths: [1,1],
  dateFormat: "yy-MM-dd",
  beforeShowDay: enableSpecificDates,
  onSelect: function(dateText, inst) {
      var check_in = $.datepicker.parseDate("yy-MM-dd", $("#check_in").val());
      var check_out = $.datepicker.parseDate("yy-MM-dd", $("#check_out").val());
      var selectedDate = $.datepicker.parseDate("yy-MM-dd", dateText);

      var mo = inst.currentMonth + 1;
      if (mo < 10) { mo = '0' + mo; }
      var chosenDate = String(inst.currentYear) + '-' + mo + '-' + inst.currentDay;

      if (!check_in || check_out) {
          $("#check_in").val(dateText);
          $("#check_out").val("");
          id = [];
      } else if( selectedDate < check_in ) {
          $("#check_out").val( $("#check_in").val() );
          $("#check_in").val(dateText);
      } else {
          $("#check_out").val(dateText);
      }
      id.push((_.invert(available_obj))[chosenDate]);
      $("#availabledate_id").val(id);
  }
});
