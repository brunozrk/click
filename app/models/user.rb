class User < ActiveRecord::Base
  HOURS_IN_GROUPS_OF_FIVE_MINUTES = (Time.now.beginning_of_day.to_i..Time.now.end_of_day.to_i).
    to_a.in_groups_of(5.minutes).collect(&:first).collect { |t| Time.at(t).strftime("%H:%M") }

  has_many :reports
  has_many :timetables

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :hours_per_day, presence: true
  validates :hours_per_day, inclusion: { in: HOURS_IN_GROUPS_OF_FIVE_MINUTES }

  def total_balance
    nearest_timetable = timetables.first
    closing_day = nearest_timetable ? nearest_timetable.closing_day : reports.last_day - 1
    balance(reports.where('day > ?', closing_day))
  end

  def balance_in_range(from, to)
    filtered_reports = reports.find_by_date_range(from, to)
    balance(filtered_reports)
  end

  private

  def balance(reports)
    positive = reports.reduce(0) { |a, e| e.balance[:sign] ? a + e.balance[:time] : a }
    negative = reports.reduce(0) { |a, e| !e.balance[:sign] ? a + e.balance[:time] : a }

    if positive >= negative
      { time: positive - negative, sign: true }
    else
      { time: negative - positive, sign: false }
    end
  end
end
