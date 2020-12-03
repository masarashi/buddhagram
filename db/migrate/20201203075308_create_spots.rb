class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string :name,       null: false
      t.text :content
      t.string :zip,        null: false
      t.string :country,    null: false
      t.string :prefecture, null: false
      t.string :city,       null: false
      t.string :address1,   null: false
      t.string :address2
      t.text :url

      t.timestamps
    end
    add_index :spots, :name, unique: true
  end
end
