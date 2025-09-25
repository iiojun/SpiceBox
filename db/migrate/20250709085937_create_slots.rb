class CreateSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :slots do |t|
      t.references :track, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :chair
      t.string :room
      t.string :s_type
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
