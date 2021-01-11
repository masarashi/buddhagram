class Statue < ApplicationRecord
  before_create :default_image

  has_many :storehouses, dependent: :destroy
  has_many :spots, through: :storehouses
  has_one_attached :image

  validates :name,    presence: true, uniqueness: { case_sensitive: true }  # 大文字と小文字を区別する
  validates :ruby,    presence: true, uniqueness: { case_sensitive: true }  # 大文字と小文字を区別する
  validates :grade,   presence: true
  validates :content, length: { maximum: 512 }

  def default_image
    if !self.image.attached?
      self.image.attach(io: File.open(Rails.root.join('app', 'javascript', 'images', 'noimage.png')),
                        filename: 'noimage.png', content_type: 'image/png')
    end
  end
end
