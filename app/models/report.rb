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
    if away
      { time: 8.hour, sign: false }
    elsif 8.hour > worked
      { time: 8.hour - worked, sign: false }
    else
      { time: worked - 8.hour, sign: true }
    end
  end

  def self.find_by_date_range(from, to)
    where('day >= ? AND day <= ?', from, to)
  end

  private

  def validate_entry_exit_order
    return unless any_higher?(first_entry, 3) ||
                  any_higher?(first_exit, 2) ||
                  any_higher?(second_entry, 1)
    errors.add(:base, 'Sequência de entrada/saída inválida')
  end

  def any_higher?(value, lasts)
    (times.last(lasts).compact).any? { |x| x < timeit(value) }
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
