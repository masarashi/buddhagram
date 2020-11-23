module PostsHelper
  def render_with_hashtags(content)
    sanitize content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post/hashtag/#{word.delete('#')}", class: 'hashtag' }
  end
end
