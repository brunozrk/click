class ChangeReportsRemoteDefault < ActiveRecord::Migration
  def change
    change_column :reports, :remote, :string, :default => '00:00'
  end
end
