require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'user creates a new post' do
    user = FactoryBot.create(:user)

    sign_in user
    visit root_path

    expect do
      click_on '投稿する'
      click_on '場所を追加しない'
      attach_file 'post_images', '/buddhagram/app/javascript/images/user-icon.png'
      fill_in 'post_content', with: 'Test Post'
      click_on '投稿'

      expect(page).to have_content '投稿しました'
      expect(page).to have_content 'Test Post'
      expect(page).to have_content user.name.to_s
    end.to change(user.posts, :count).by(1)
  end

  it 'user creates a new post with spot' do
    user = FactoryBot.create(:user)
    spot = FactoryBot.create(:spot)
    search_keyword = spot.name

    sign_in user
    visit root_path

    expect do
      click_on '投稿する'

      fill_in 'search_keyword', with: spot.name
      click_button '検索'
      sleep 0.5
      click_on spot.name.to_s

      expect(page).to have_content spot.name.to_s
      attach_file 'post_images', '/buddhagram/app/javascript/images/user-icon.png'
      fill_in 'post_content', with: 'Test Post'
      click_on '投稿'

      expect(page).to have_content '投稿しました'
      expect(page).to have_content 'Test Post'
      expect(page).to have_content user.name.to_s
    end.to change(user.posts, :count).by(1)
  end

  it 'user edits a own post' do
    post = FactoryBot.create(:post)

    sign_in post.user
    visit post_path(post)

    click_on '編集'
    fill_in 'post_content', with: 'Content Update'
    click_on '更新'
    expect(page).to have_content 'Content Update'
  end

  it 'user deletes a own post' do
    post = FactoryBot.create(:post)

    sign_in post.user
    visit post_path(post)

    click_on '編集'
    click_on '削除'

    expect do
      expect(page.accept_confirm).to eq '本当に削除しますか？'
      expect(page).to have_content '投稿を削除しました'
    end.to change(post.user.posts, :count).by(-1)
  end
end
