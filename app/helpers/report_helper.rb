module ReportHelper
  def sign(balance)
    if balance[:sign]
      "- #{hour_minute(balance[:time])}"
    else
      "+ #{hour_minute(balance[:time])}"
    end
  end

  def hour_minute(worked)
    Time.at(worked).gmtime.strftime('%H:%M')
  end
end
