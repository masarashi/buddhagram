require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  scenario "user can follow a other user" do
    userA = FactoryBot.create(:user)
    userB = FactoryBot.create(:user)

    visit new_user_session_path
    click_link "ログイン"
    fill_in "user_email", with: userA.email
    fill_in "user_password", with: userA.password
    click_button "ログイン"

    expect {
      visit user_path(userB)
      click_button "フォローする"
    }.to change { userA.following.count }.by(1).and change { userB.followers.count }.by(1)
  end

  scenario "user can unfollow a other user" do
    userA = FactoryBot.create(:user)
    userB = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "user_email", with: userA.email
    fill_in "user_password", with: userA.password
    click_button "ログイン"
    visit user_path(userB)
    click_button "フォローする"

    expect {
      click_button "フォロー中"
    }.to change { userA.following.count }.by(-1).and change { userB.followers.count }.by(-1)
  end
end
