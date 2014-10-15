module ReportHelper
  def total(report)
    first_entry = timeit(report.first_entry)
    first_exit = timeit(report.first_exit)
    second_entry = timeit(report.second_entry)
    second_exit = timeit(report.second_exit)
    Time.at((first_exit - first_entry) + (second_exit - second_entry)).gmtime.strftime('%H:%M')
  end

  def balance(report)
    first_entry = timeit(report.first_entry)
    first_exit = timeit(report.first_exit)
    second_entry = timeit(report.second_entry)
    second_exit = timeit(report.second_exit)
    Time.at( 8.hour - ((first_exit - first_entry) + (second_exit - second_entry))).gmtime.strftime('%H:%M')
    binding.pry
  end

  private

  def timeit(value)
    Time.parse(value) unless value.empty?
  end
end
