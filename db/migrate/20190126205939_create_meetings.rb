class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.belongs_to :club, index: true, foreign_key: true, null: false

      t.string :title
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.text :description
      t.text :notes
      t.integer :attendances_count, default: 0, null: false

      t.timestamps
    end
  end
end
