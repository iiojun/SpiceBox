class CreatePresentations < ActiveRecord::Migration[8.0]
  def change
    create_table :presentations do |t|
      t.references :slot, null: false, foreign_key: true
      t.string :title
      t.string :authors
      t.string :presenter
      t.text :description
      t.string :contact_email
      t.string :url
      t.string :misc
      t.boolean :evaluated
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
