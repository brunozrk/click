$(document).ready(function(){
  //Timepicker
  $(".timepicker").timepicker({
    showMeridian: false,
    showInputs: false,
    minuteStep: 1,
    defaultTime: false
  });

  $(".datepicker").datepicker({
    format: "dd/mm/yyyy",
    language: 'pt-BR'
  });
});
