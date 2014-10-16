class Report < ActiveRecord::Base
  belongs_to :user

  validates :day, :remote, presence: true

  validates :day, uniqueness: { scope: :user_id }

  default_scope { order('day DESC') }

  def worked
    first_total = time_diff(first_entry, first_exit)
    second_total = time_diff(second_entry, second_exit)
    first_total + second_total + timeit(remote).seconds_since_midnight
  end

  def balance
    if 8.hour > worked
      { time: 8.hour - worked, sign: true }
    else
      { time: worked - 8.hour, sign: false }
    end
  end

  private

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
    Time.parse(value) unless value.empty?
  end
end
