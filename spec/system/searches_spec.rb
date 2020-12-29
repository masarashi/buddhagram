require 'rails_helper'

RSpec.describe "Searches", type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  scenario "user searches for users", js: true do
    user = FactoryBot.create(:user)
    search_keyword = user.name

    visit search_path
    fill_in "search_keyword", with: search_keyword
    click_on "検索"
    sleep 0.5

    expect(page).to have_selector "#user", text: search_keyword
  end

  scenario "user searches for statues", js: true do
    statue = FactoryBot.create(:statue)
    search_keyword = statue.name

    visit search_path
    fill_in "search_keyword", with: search_keyword
    click_on "検索"
    sleep 0.5

    expect(page).to have_selector "#statue", text: search_keyword
  end

  scenario "user searches for spots", js: true do
    spot = FactoryBot.create(:spot)
    search_keyword = spot.name

    visit search_path
    fill_in "search_keyword", with: search_keyword
    click_on "検索"
    sleep 0.5

    expect(page).to have_selector "#spot", text: search_keyword
  end

  scenario "user searches for hashtags", js: true do
    post = FactoryBot.create(:post, :with_hashtags)
    search_keyword = post.hashtags[0].name

    visit search_path
    fill_in "search_keyword", with: search_keyword
    click_on "検索"
    sleep 0.5

    expect(page).to have_selector "#hashtag", text: search_keyword
  end

  scenario "user searches for non existent object fail", js: true do
    visit search_path
    fill_in "search_keyword", with: "ああああああああああ"
    click_on "検索"
    sleep 0.5

    expect(page).to have_content "検索結果がありません"
  end

  scenario "user searches for blank fail", js: true do
    visit search_path
    click_on "検索"
    sleep 0.5

    expect(page).to have_content "キーワードを入力してください"
  end
end
