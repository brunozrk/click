class ChangeHoursPerDayToString < ActiveRecord::Migration
  def up
    change_column :users, :hours_per_day, :string, default: '08:00'
    new_hours_per_day
  end

  def down
    rollback_new_hours_per_day
    change_column :users, :hours_per_day, :integer, default: 8
  end

  private
  def new_hours_per_day
    User.find_each do |user|
      new_hours_per_day_hour = user.hours_per_day.to_i < 10 ? "0#{user.hours_per_day}" : user.hours_per_day
      user.update_attributes(hours_per_day: "#{new_hours_per_day_hour}:00")
    end
  end

  def rollback_new_hours_per_day
    User.find_each do |user|
      old_hours_per_day_hour = user.hours_per_day.split(':')[0]
      user.update_attributes(hours_per_day: old_hours_per_day_hour)
    end
  end
end
