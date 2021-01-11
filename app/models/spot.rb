class Spot < ApplicationRecord
  geocoded_by :name
  after_validation :geocode
  before_create :default_image

  has_many :posts
  has_many :storehouses, dependent: :destroy
  has_many :statues, through: :storehouses
  has_one_attached :image

  validates :name,      presence: true, uniqueness: { case_sensitive: true }  # 大文字と小文字を区別する
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

  def default_image
    image.attach(io: File.open(Rails.root.join('app/javascript/images/noimage.png')),
                 filename: 'noimage.png', content_type: 'image/png')
  end
end
