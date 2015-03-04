class PdfReport
  attr_reader :data, :from, :to

  TABLE_HEADER = [
    'Dia',
    'Primeira Entrada',
    'Primeira Saída',
    'Segunda Entrada',
    'Segunda Saída',
    'Remoto',
    'Total',
    'Saldo'
  ]

  SIGN = {
    true => '+',
    false => '-'
  }

  def initialize(data, from, to)
    @data = data
    @from = from.strftime('%d/%m/%Y')
    @to = to.strftime('%d/%m/%Y')
  end

  def generate
    render
    pdf
  end

  private

  def render
    page_header
    reports_list
  end

  def pdf
    @pdf ||= Prawn::Document.new(page_size: 'A4', page_layout: :landscape, margin: [50, 30, 30, 30])
  end

  def page_header
    pdf.text 'Click',
             size: 30,
             align: :left,
             inline_format: true,
             color: '367fa9'

    pdf.text_box 'clickhoras.com | Controle de horas online',
                 size: 10,
                 align: :left,
                 inline_format: true,
                 at: [2, 480],
                 style: :italic

    pdf.text "#{from} à #{to}",
             size: 10,
             align: :right,
             inline_format: true
  end

  def reports_list
    pdf.move_down 20
    options = {
      width: 782,
      row_colors: %w(DDDDDD FFFFFF),
      header: true
    }

    pdf.table([TABLE_HEADER, *table_rows], options) do
      row(0).font_style = :bold
      row(0).background_color = '777777'
      row(0).text_color = 'FFFFFF'
    end
  end

  def table_rows
    data.map do |report|
      [
        report.day.strftime('%d/%m/%Y'),
        report.first_entry,
        report.first_exit,
        report.second_entry,
        report.last_exit,
        report.remote,
        h.format_time(report.worked),
        sign(report)
      ]
    end
  end

  def sign(report)
    "#{SIGN.fetch(report.balance[:sign])} #{h.format_time(report.balance[:time])}"
  end

  def h
    ApplicationController.helpers
  end
end
