class CreateStorehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :storehouses do |t|
      t.references :spot, null: false, foreign_key: true
      t.references :statue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
