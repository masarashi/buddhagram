class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  before_create :default_image

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one_attached :image

  validates :name,    presence: true, length: { maximum: 32 }, uniqueness: { case_sensitive: true }  # 大文字と小文字を区別する
  validates :profile, length: { maximum: 256 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png], message: "画像はjpeg、gif、png形式のみアップロード可能です" },
                      size: { less_than: 5.megabytes, message: "画像は5MB未満にしてください" }

  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end

  def feed
    following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id).with_attached_images.includes(:user, :spot, :comments, user: [image_attachment: :blob]).order(created_at: :desc)
  end

  def follow(other_user)
    following << other_user
    # active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def default_image
    if !self.image.attached?
      self.image.attach(io: File.open(Rails.root.join('app', 'javascript', 'images', 'user-icon.png')), filename: 'user-icon.png', content_type: 'image/png')
    end
  end
end
