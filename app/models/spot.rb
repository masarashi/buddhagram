class Spot < ApplicationRecord
  geocoded_by :name
  after_validation :geocode

  class << self
    def within_box(distance, latitude, longitude)
      distance = distance
      center_point = [latitude, longitude]
      box = Geocoder::Calculations.bounding_box(center_point, distance)
      within_bounding_box(box)
    end
  end
end
