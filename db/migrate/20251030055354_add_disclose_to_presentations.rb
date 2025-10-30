class AddDiscloseToPresentations < ActiveRecord::Migration[8.0]
  def change
    add_column :presentations, :disclose, :boolean, default: false
  end
end
