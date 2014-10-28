class User < ActiveRecord::Base
  has_many :reports

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :hours_per_day, presence: true
  validates :hours_per_day, inclusion: { in: 1..24 }

  def total_balance
    positive = reports.reduce(0) { |a, e| e.balance[:sign] ? a + e.balance[:time] : a }
    negative = reports.reduce(0) { |a, e| !e.balance[:sign] ? a + e.balance[:time] : a }

    if positive >= negative
      { time: positive - negative, sign: true }
    else
      { time: negative - positive, sign: false }
    end
  end
end
