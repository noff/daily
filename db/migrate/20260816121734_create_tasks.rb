class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :summary
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :day, null: false, foreign_key: true
      t.timestamps
    end
  end
end
