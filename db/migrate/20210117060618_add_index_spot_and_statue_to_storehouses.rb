class AddIndexSpotAndStatueToStorehouses < ActiveRecord::Migration[6.0]
  def change
    add_index :storehouses, %i[spot_id statue_id], unique: true
  end
end
