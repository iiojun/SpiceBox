class CreateEvaluations < ActiveRecord::Migration[8.0]
  def change
    create_table :evaluations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :presentation, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
