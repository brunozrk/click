class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :first_entry
      t.string :first_exit
      t.string :second_entry
      t.string :second_exit
      t.string :remote

      t.date :day

      t.boolean :away, default: false

      t.text :notice

      t.references :user, index: true

      t.timestamps
    end
  end
end
