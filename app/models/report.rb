class Report < ActiveRecord::Base
  belongs_to :user

  validates :day, :remote, presence: true

  validates :day, uniqueness: { scope: :user_id }

  validate :validate_entry_exit_order

  default_scope { order('day DESC') }

  def worked
    first_total = time_diff(first_entry, first_exit)
    second_total = time_diff(second_entry, second_exit)
    first_total + second_total + timeit(remote).seconds_since_midnight
  end

  def balance
    return { time: worked, sign: true } unless working_day

    hours_per_day = user.hours_per_day
    if away
      { time: hours_per_day.hour, sign: false }
    elsif hours_per_day.hour > worked
      { time: hours_per_day.hour - worked, sign: false }
    else
      { time: worked - hours_per_day.hour, sign: true }
    end
  end

  def estimated_exit
    return unless can_estimate?
    Time.parse(second_entry) + balance.fetch(:time)
  end

  def self.find_by_date_range(from, to)
    where('day >= ? AND day <= ?', from, to)
  end

  def self.last_day
    last ? last.day : Date.today
  end

  private

  def can_estimate?
    return false unless second_exit.blank?
    [first_entry, first_exit, second_entry].each do |f|
      return false if f.blank?
    end
    true
  end

  def validate_entry_exit_order
    return unless any_higher?(first_entry, 3) ||
                  any_higher?(first_exit, 2) ||
                  any_higher?(second_entry, 1)
    errors.add(:base, I18n.t('flash.reports.validations.entry_exit_order'))
  end

  def any_higher?(value, last)
    last_fills = times.last(last).compact
    return true if require_previous_fill?(value, last_fills)
    last_fills.any? { |x| x < timeit(value) }
  end

  def require_previous_fill?(value, last_fills)
    value.blank? && !last_fills.empty?
  end

  def times
    [
      timeit(first_entry),
      timeit(first_exit),
      timeit(second_entry),
      timeit(second_exit)
    ]
  end

  def time_diff(entry, exit)
    entry = timeit(entry)
    exit = timeit(exit)
    if exit && entry
      exit - entry
    else
      0
    end
  end

  def timeit(value)
    return if value.nil?
    Time.parse(value) unless value.empty?
  end
end
