require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'user follow and unfollow a other user', js: true do
    userA = FactoryBot.create(:user)
    userB = FactoryBot.create(:user)

    sign_in userA
    visit user_path(userB)

    expect do
      click_on 'フォローする'
      expect(page).to have_button 'フォロー中'
    end.to change { userA.following.count }.by(1).and change { userB.followers.count }.by(1)

    expect do
      click_on 'フォロー中'
      sleep 0.5
      expect(page).to have_button 'フォローする'
    end.to change { userA.following.count }.by(-1).and change { userB.followers.count }.by(-1)
  end
end
