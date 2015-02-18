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

  def pop_over_info(notice, working_day)
    return if notice.blank? && working_day
    "<i popover data-toggle='popover'
                data-content='#{h notice} #{nonworking_day(working_day)}'
                data-placement='left'
                class='fa fa-fw fa-info-circle'>
    </i>".html_safe
  end

  private

  def nonworking_day(working_day)
    return if working_day
    '(Dia não útil)'
  end
end
