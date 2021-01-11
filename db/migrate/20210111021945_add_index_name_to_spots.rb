class AddIndexNameToSpots < ActiveRecord::Migration[6.0]
  def change
    remove_index :spots, column: :name
    add_index :spots, :name, unique: true
  end
end
