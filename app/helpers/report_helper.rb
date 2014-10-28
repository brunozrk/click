module ReportHelper
  def sign(balance, color = nil)
    if balance[:sign]
      balance_html(balance[:time], color || 'green', 'plus')
    else
      balance_html(balance[:time], color || 'red', 'minus')
    end
  end

  def hour_minute(worked)
    hours = worked / (60 * 60)
    minutes = (worked / 60) % 60
    format('%02d:%02d', hours, minutes)
  end

  private

  def balance_html(time, color, icon)
    "<span class='text-#{color}'>
      <i class='fa fa-fw fa-#{icon}-circle'></i>
      #{hour_minute(time)}
    </span>".html_safe
  end
end
