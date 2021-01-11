require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'user successfully signs up' do
    visit root_path
    click_link 'アカウント登録'

    expect do
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_name', with: 'User Name'
      fill_in 'user_password', with: 'test123'
      fill_in 'user_password_confirmation', with: 'test123'
      click_button 'アカウント登録'
    end.to change(User, :count).by(1)

    expect(page).to have_content 'アカウント登録が完了しました。'
    expect(page).to have_current_path root_path, ignore_query: true
  end
end
