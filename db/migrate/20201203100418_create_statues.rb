class CreateStatues < ActiveRecord::Migration[6.0]
  def change
    create_table :statues do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :statues, :name, unique: true
  end
end
