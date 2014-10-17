module ReportHelper
  def sign(balance)
    if balance[:sign]
      "<span class='text-green'>+ #{hour_minute(balance[:time])}</span>".html_safe
    else
      "<span class='text-red'>- #{hour_minute(balance[:time])}</span>".html_safe
    end
  end

  def hour_minute(worked)
    Time.at(worked).gmtime.strftime('%H:%M')
  end
end
