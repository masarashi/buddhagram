module PostsHelper
  def render_with_hashtags(content)
    sanitize content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post/hashtag/#{word.delete('#')}", class: 'hashtag' }
  end

  def post_image(image)
    image.variant(resize_to_fit: [600, nil])
  end
end