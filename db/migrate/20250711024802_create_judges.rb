class CreateJudges < ActiveRecord::Migration[8.0]
  def change
    create_table :judges do |t|
      t.references :evaluation, null: false, foreign_key: true
      t.string :question
      t.integer :value

      t.timestamps
    end
  end
end
