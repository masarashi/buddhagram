require 'rails_helper'

RSpec.describe 'Spots', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'admin creates the spot' do
    admin = FactoryBot.create(:user, :admin)

    sign_in admin
    visit spots_geocoding_search_path

    fill_in 'search_name', with: '法隆寺'
    click_button '検索'
    click_on '登録する'
    expect(page).to have_content '登録しました'
    expect(page).to have_content '法隆寺'
  end

  # scenario "admin edits the spot" do
  #   admin = FactoryBot.create(:user, :admin)
  #   spot = FactoryBot.create(:spot)

  #   sign_in admin
  #   visit spot_path(spot)

  #   click_on "編集"
  #   fill_in "spot_name", with: ""
  #   fill_in "spot_country", with: ""
  #   fill_in "spot_state", with: ""
  #   fill_in "spot_address", with: ""
  #   fill_in "spot_content", with: ""
  #   click_on "更新"

  #   expect(page).to have_content ""
  #   expect(page).to have_content ""
  #   expect(page).to have_content ""
  #   expect(page).to have_content ""
  #   expect(page).to have_content ""
  # end

  it 'admin deletes the spot' do
    admin = FactoryBot.create(:user, :admin)
    spot = FactoryBot.create(:spot)

    sign_in admin
    visit spot_path(spot)
    click_on '編集'
    click_on '削除'
    expect(page.accept_confirm).to eq '本当に削除しますか？'
    expect(page).to have_content '削除しました'
  end

  it 'spot has statues' do
    spot = FactoryBot.create(:spot, :with_statues)

    visit spot_path(spot)

    expect(page).to have_selector 'a', text: spot.statues[0].name
  end

  it 'show page is include post with same spot' do
    post = FactoryBot.create(:post, :with_spots)

    visit spot_path(post.spot)

    expect(page).to have_link nil, href: post_path(post)
  end

  it 'search near spots' do
    # visit search_path

    # click_on "現在地周辺スポットを探す"

    # sleep 2
    # take_screenshot

    # expect(page).to have_content "現在地からの距離"
  end
end
