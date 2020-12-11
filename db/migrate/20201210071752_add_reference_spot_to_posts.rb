class AddReferenceSpotToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :spot, foreign_key: true
  end
end
