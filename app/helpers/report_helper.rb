module ReportHelper
  def sign(balance, color = nil)
    if balance[:sign]
      balance_html(balance[:time], color || 'green', 'plus')
    else
      balance_html(balance[:time], color || 'red', 'minus')
    end
  end

  def hour_minute(worked)
    Time.at(worked).gmtime.strftime('%H:%M')
  end

  private

  def balance_html(time, color, icon)
    "<span class='text-#{color}'>
      <i class='fa fa-fw fa-#{icon}-circle'></i>
      #{hour_minute(time)}
    </span>".html_safe
  end
end
