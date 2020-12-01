require 'rails_helper'

RSpec.describe "Posts", type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  scenario "user creates a new post" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"

    expect {
      click_link "投稿する"
      attach_file "post_images", "/buddhagram/app/javascript/images//user-icon.png"
      fill_in "post_content", with: "Test Post"
      click_button "投稿"

      expect(page).to have_content "投稿しました"
      expect(page).to have_content "Test Post"
      expect(page).to have_content "#{user.name}"
    }.to change(user.posts, :count).by(1)
  end
end
