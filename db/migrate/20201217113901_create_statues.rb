class CreateStatues < ActiveRecord::Migration[6.0]
  def change
    create_table :statues do |t|
      t.string :name
      t.string :ruby
      t.string :grade
      t.text :content

      t.timestamps
    end
    add_index :statues, :name, unique: true
  end
end
