class Statue < ApplicationRecord
  has_many :storehouses, dependent: :destroy
  has_many :spots, through: :storehouses
  has_one_attached :image

  validates :name,    presence: true, uniqueness: true
  validates :ruby,    presence: true, uniqueness: true
  validates :grade,   presence: true
  validates :content, length: { maximum: 512 }
end
