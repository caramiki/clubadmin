class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.belongs_to :club, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.string :first_name
      t.string :last_name
      t.text :notes

      t.timestamps
    end
  end
end
