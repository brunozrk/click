$(document).ready(function(){
  $(".timepicker").timepicker({
    showMeridian: false,
    showInputs: false,
    minuteStep: 5,
    defaultTime: false
  }).on('focus', function(){
    $('.timepicker').not(this).timepicker('hideWidget');
  });

  $('#report_notice').on('focus', function(){
    $('.timepicker').timepicker('hideWidget');
  });

  $(".datepicker").datepicker({
    format: "dd/mm/yyyy",
    todayBtn: 'linked',
    language: 'pt-BR'
  });

  $('[popover]').popover({ trigger: "hover" });
});

$(document).click(function(){
  if(event.target.classList.contains('timepicker') != true){
    $('.timepicker').timepicker('hideWidget');
  }
});
