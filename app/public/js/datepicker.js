$(".datepicker").datepicker({
  minDate: 0,
  numberOfMonths: [1,1],
  beforeShowDay: function(date) {
      var check_in = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#check_in").val());
      var check_out = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#check_out").val());
      return [true, check_in && ((date.getTime() == check_in.getTime()) || (check_out && date >= check_in && date <= check_out)) ? "dp-highlight" : ""];
  },
  onSelect: function(dateText, inst) {
      var check_in = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#check_in").val());
      var check_out = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#check_out").val());
      var selectedDate = $.datepicker.parseDate($.datepicker._defaults.dateFormat, dateText);

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
