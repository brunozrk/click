class Report < ActiveRecord::Base
  belongs_to :user

  validates :day, presence: true
end
