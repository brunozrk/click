class Report < ActiveRecord::Base
  belongs_to :user

  validates :day, presence: true

  validates :day, uniqueness: true

  default_scope { order('day DESC') }
end
