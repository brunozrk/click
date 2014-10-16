module ReportHelper
  def total(report)
    hour_minute(worked(report))
  end

  def balance(report)
    worked = worked(report)
    if 8.hour > worked
      "- #{hour_minute(8.hour - worked)}"
    else
      "+ #{hour_minute(worked - 8.hour)}"
    end
  end

  private

  def hour_minute(worked)
    Time.at(worked).gmtime.strftime('%H:%M')
  end

  def worked(report)
    first_entry, first_exit, second_entry, second_exit = report_values(report)

    first_total = time_diff(first_entry, first_exit)
    secont_total = time_diff(second_entry, second_exit)

    first_total + secont_total
  end

  def time_diff(entry, exit)
    if exit && entry
      exit - entry
    else
      0
    end
  end

  def report_values(report)
    [
      timeit(report.first_entry),
      timeit(report.first_exit),
      timeit(report.second_entry),
      timeit(report.second_exit)
    ]
  end

  def timeit(value)
    Time.parse(value) unless value.empty?
  end
end
