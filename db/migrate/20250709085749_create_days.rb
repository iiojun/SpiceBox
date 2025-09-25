class CreateDays < ActiveRecord::Migration[8.0]
  def change
    create_table :days do |t|
      t.references :conference, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :seq_no

      t.timestamps
    end
  end
end
