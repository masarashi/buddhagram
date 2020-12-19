class Statue < ApplicationRecord
  has_many :storehouses, dependent: :destroy
  has_many :spots, through: :storehouses
  has_one_attached :image
end
