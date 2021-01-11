class Hashtag < ApplicationRecord
  # has_many :taggings, foreign_key: 'hashtag_id', dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
end
