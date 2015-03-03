module ReportHelper
  TEXT_COLOR = { true => 'green', false => 'red' }
  ICON = { true => 'plus', false => 'minus' }

  def text_color(status)
    TEXT_COLOR.fetch(status)
  end

  def icon(status)
    ICON.fetch(status)
  end

  def format_time(time)
    hours = time / (60 * 60)
    minutes = (time / 60) % 60
    format('%02d:%02d', hours, minutes)
  end
end
