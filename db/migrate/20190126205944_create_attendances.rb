class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.belongs_to :member, index: true, foreign_key: true, null: false
      t.belongs_to :meeting, index: true, foreign_key: true, null: false
      t.datetime :arrival_time
      t.datetime :departure_time
      t.text :notes

      t.timestamps
    end
  end
end
