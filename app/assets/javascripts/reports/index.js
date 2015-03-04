$(document).ready(function(){
  $('#daterange-btn').daterangepicker({
    ranges: {
      'Hoje': [moment(), moment()],
      'Ontem': [moment().subtract('days', 1), moment().subtract('days', 1)],
      'Últimos 7 dias': [moment().subtract('days', 6), moment()],
      'Últimos 30 dias': [moment().subtract('days', 29), moment()],
      'Esse mês': [moment().startOf('month'), moment().endOf('month')],
      'Ultimos mês': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
    },
    locale: {
      applyLabel: 'Aplicar',
      cancelLabel: 'Cancelar',
      fromLabel: 'Dê',
      toLabel: 'Até',
      weekLabel: 'W',
      customRangeLabel: 'Personalizar Data'
    },
    startDate: moment().subtract('days', 29),
    endDate: moment()
  },

  function(start, end) {
    $('#date_range_from').val(start.format('DD/MM/YYYY'));
    $('#date_range_to').val(end.format('DD/MM/YYYY'));
  });

  $('#pdf_export').on('click', function(){
    from = $('#date_range_from').val();
    to = $('#date_range_to').val();
    window.open($(this).data('url') + '?from='+ from +'&to=' + to);
  });
});
