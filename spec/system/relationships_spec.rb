require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'user follow and unfollow a other user', js: true do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)

    sign_in user1
    visit user_path(user2)

    expect do
      click_on 'フォローする'
      expect(page).to have_button 'フォロー中'
    end.to change { user1.following.count }.by(1).and change { user2.followers.count }.by(1)

    expect do
      click_on 'フォロー中'
      sleep 0.5
      expect(page).to have_button 'フォローする'
    end.to change { user1.following.count }.by(-1).and change { user2.followers.count }.by(-1)
  end
end
