class Report < ActiveRecord::Base
  belongs_to :user

  validates :day, :remote, presence: true
  validate :validate_entry_exit_order

  default_scope { order('day DESC') }

  NEGATIVE = false
  POSITIVE = true

  def worked
    first_total  = time_diff(first_entry, first_exit)
    second_total = time_diff(second_entry, second_exit)
    third_total  = time_diff(third_entry, third_exit)

    first_total + second_total + third_total + timeit(remote).seconds_since_midnight
  end

  def balance
    return { time: worked, sign: POSITIVE } unless working_day

    hours_per_day = Time.parse(user.hours_per_day).seconds_since_midnight
    time, sign = away ?  [hours_per_day, NEGATIVE] : [balance_diff(hours_per_day), positive_balance?(hours_per_day)]

    { time: time, sign: sign }
  end

  def self.find_by_date_range(from, to)
    where('day >= ? AND day <= ?', from, to)
  end

  def self.last_day
    last ? last.day : Date.today
  end

  private

  def validate_entry_exit_order
    return if times.compact == times.compact.sort

    errors.add(:base, I18n.t('flash.reports.validations.entry_exit_order'))
  end

  def times
    [
      timeit(first_entry),
      timeit(first_exit),
      timeit(second_entry),
      timeit(second_exit),
      timeit(third_entry),
      timeit(third_exit)
    ]
  end

  def time_diff(entry, exit)
    entry = timeit(entry)
    exit  = timeit(exit)

    if exit && entry
      exit - entry
    else
      0
    end
  end

  def timeit value
    return if value.nil?
    Time.parse(value) unless value.empty?
  end

  def balance_diff hours_per_day
    (worked - hours_per_day).abs
  end

  def positive_balance? hours_per_day
    hours_per_day <= worked
  end
end
