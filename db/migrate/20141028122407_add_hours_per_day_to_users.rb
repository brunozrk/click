class AddHoursPerDayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hours_per_day, :integer, default: 8
  end
end
