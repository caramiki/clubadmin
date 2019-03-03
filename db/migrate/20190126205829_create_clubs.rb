class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.belongs_to :creator, index: true, foreign_key: { to_table: :users }

      t.string :name, null: false
      t.text :description
      t.string :timezone, null: false, default: "Etc/UTC"

      t.timestamps
    end
  end
end
