$(document).ready(function(){
  $(".timepicker").timepicker({
    showMeridian: false,
    showInputs: false,
    minuteStep: 1,
    defaultTime: false
  }).on('blur', function(){
    $(this).timepicker("hideWidget");
  });

  $(".datepicker").datepicker({
    format: "dd/mm/yyyy",
    todayBtn: 'linked',
    language: 'pt-BR'
  });

  $('[popover]').popover({ trigger: "hover" });
});
