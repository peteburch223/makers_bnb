var available_obj = gon.available_dates;

var dates = [];

for (var key in available_obj) {
  dates.push(available_obj[key]);
}

function enableSpecificDates(date) {
  var m = date.getMonth() + 1;
  if (m < 10) { m = '0' + m; }
  var d = date.getDate();
  if (d < 10) { d = '0' + d; }
  var y = date.getFullYear();
  var currentDate = y + '-' + m + '-' + d;

  for (var i = 0; i < dates.length; i++) {
    if ($.inArray(currentDate, dates) != -1 ) {
      var check_in = $.datepicker.parseDate("yy-MM-dd", $("#check_in").val());
      var check_out = $.datepicker.parseDate("yy-MM-dd", $("#check_out").val());
      return [true, check_in && ((date.getTime() == check_in.getTime()) || (check_out && date >= check_in && date <= check_out)) ? "dp-highlight" : ""];
    } else {
      return [false];
    }
  }
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

      if (!check_in || check_out) {
          $("#check_in").val(dateText);
          $("#check_out").val("");
          $(this).datepicker();
      } else if( selectedDate < check_in ) {
          $("#check_out").val( $("#check_in").val() );
          $("#check_in").val( dateText );
          $(this).datepicker();
      } else {
          $("#check_out").val(dateText);
          $(this).datepicker();
      }
  }
});
