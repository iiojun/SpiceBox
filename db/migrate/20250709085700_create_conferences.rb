class CreateConferences < ActiveRecord::Migration[8.0]
  def change
    create_table :conferences do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.integer :duration

      t.timestamps
    end
  end
end
