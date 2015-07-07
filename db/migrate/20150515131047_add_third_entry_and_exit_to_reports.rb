class AddThirdEntryAndExitToReports < ActiveRecord::Migration
  def change
    add_column :reports, :third_entry, :string
    add_column :reports, :third_exit, :string
  end
end
