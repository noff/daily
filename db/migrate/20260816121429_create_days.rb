class CreateDays < ActiveRecord::Migration[8.1]
  def change
    create_table :days do |t|
      t.date :date
      t.integer :success_rate
      t.timestamps
    end
    add_index :days, :date, unique: true
  end
end
