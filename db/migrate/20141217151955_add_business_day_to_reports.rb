class AddBusinessDayToReports < ActiveRecord::Migration
  def change
    add_column :reports, :working_day, :boolean, default: true
  end
end
