class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spot, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :taggings, dependent: :destroy
  has_many :hashtags, through: :taggings
  has_many_attached :images

  # def likes_count(post)
  #   likes.count
  # end

  after_create do
    #1 controller側でcreateしたTweetを取得
    post = Post.find_by(id: id)
    #2 正規表現を用いて、Tweetのtext内から『#○○○』の文字列を検出
    hashtags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    #3 mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
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