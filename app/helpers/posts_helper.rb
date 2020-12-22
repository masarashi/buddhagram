module PostsHelper
  include Pagy::Frontend
  
  def render_with_hashtags(content)
    sanitize content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post/hashtag/#{word.delete('#')}", class: 'hashtag' }
  end

  def resize600(image)
    image.variant(resize_to_fit: [600, nil])
  end
end
