class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string  :name,      null: false
      t.string  :country
      t.string  :state
      t.text    :address
      t.float   :latitude
      t.float   :longitude
      t.text    :content

      t.timestamps
    end
    add_index :spots, :name
    add_index :spots, [:name, :address], unique: true
  end
end
