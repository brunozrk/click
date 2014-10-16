class Report < ActiveRecord::Base
  belongs_to :user

  validates :day, presence: true

  validates :day, uniqueness: { scope: :user_id }

  default_scope { order('day DESC') }
end
