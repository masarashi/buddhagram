class Storehouse < ApplicationRecord
  belongs_to :spot
  belongs_to :statue
  # validates :spot_id, presence: true
  # validates :statue_id, presence: true
end
