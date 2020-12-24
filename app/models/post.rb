class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spot, optional: true  # spotは必須ではない

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :taggings, dependent: :destroy
  has_many :hashtags, through: :taggings

  has_many_attached :images

  validates :images,  presence: true,
                      content_type: { in: %w[image/jpeg image/gif image/png], message: "画像はjpeg、gif、png形式のみアップロード可能です" },
                      dimension: { width: 5000, height: 5000, message: "画像の大きさは5000x5000までにしてください" },
                      size: { less_than: 5.megabytes, message: "画像は5MB未満にしてください" }

  after_create do
    post = Post.find_by(id: id)
    # ハッシュタグを検出
    hashtags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    # mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
    hashtags.uniq.map do |t|
      hashtag = Hashtag.find_or_create_by(name: t.downcase.delete('#'))
      post.hashtags << hashtag
    end
  end

  before_update do
    post = Post.find_by(id: id)
    post.hashtags.clear
    hashtags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |t|
      hashtag = Hashtag.find_or_create_by(name: t.downcase.delete('#'))
      post.hashtags << hashtag
    end
  end
end
