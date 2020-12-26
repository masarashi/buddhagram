class Spot < ApplicationRecord
  geocoded_by :name
  after_validation :geocode

  has_many :posts
  has_many :storehouses, dependent: :destroy
  has_many :statues, through: :storehouses
  
  validates :name,      presence: true, uniqueness: true
  validates :country,   presence: true
  validates :state,     presence: true
  validates :address,   presence: true
  validates :latitude,  presence: true
  validates :longitude, presence: true
  validates :content,   length: { maximum: 1024 }

  # class << self
  #   def within_box(distance, latitude, longitude)
  #     distance = distance
  #     center_point = [latitude, longitude]
  #     box = Geocoder::Calculations.bounding_box(center_point, distance)
  #     within_bounding_box(box)
  #   end
  # end
end
