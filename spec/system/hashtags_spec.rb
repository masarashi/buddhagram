require 'rails_helper'

RSpec.describe 'Hashtags', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'user clicks hashtag in text' do
    post = FactoryBot.create(:post, :with_hashtags)

    visit post_path(post)
    click_link '#釈迦'

    expect(page).to have_selector 'h1', text: '#釈迦'
  end

  it 'user clicks hashtag in text on timeline' do
    post = FactoryBot.create(:post, :with_hashtags)

    sign_in post.user
    visit user_timeline_path(post.user)

    click_link '#釈迦'

    expect(page).to have_selector 'h1', text: '#釈迦'
  end

  it 'user clicks hashtag in text on search form', js: true do
    post = FactoryBot.create(:post, :with_hashtags)

    visit search_path
    fill_in 'search_keyword', with: post.hashtags[0].name
    click_on '検索'
    sleep 0.5

    link = find('#hashtag', text: '釈迦')
    link.click

    expect(page).to have_selector 'h1', text: '#釈迦'
  end

  it 'hashtag page is include post with same hashtag' do
    post = FactoryBot.create(:post, :with_hashtags)

    visit post_path(post)
    click_link '#釈迦'

    expect(page).to have_link nil, href: post_path(post)
  end
end
