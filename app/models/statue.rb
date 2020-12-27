class Statue < ApplicationRecord
  has_many :storehouses, dependent: :destroy
  has_many :spots, through: :storehouses
  has_one_attached :image

  validates :name,    presence: true, uniqueness: { case_sensitive: true }  # 大文字と小文字を区別する
  validates :ruby,    presence: true, uniqueness: { case_sensitive: true }  # 大文字と小文字を区別する
  validates :grade,   presence: true
  validates :content, length: { maximum: 512 }
end
