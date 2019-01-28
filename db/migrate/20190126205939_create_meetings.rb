class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.belongs_to :club, index: true, foreign_key: true, null: false
      t.string :title
      t.datetime :start_time, null: false
      t.datetime :end_time

      t.timestamps
    end
  end
end
