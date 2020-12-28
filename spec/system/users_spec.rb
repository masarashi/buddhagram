require 'rails_helper'

RSpec.describe "Users", type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  scenario "user successfully signs up" do
    visit root_path
    click_link "サインアップ"

    expect {
      fill_in "user_email", with: "test@example.com"
      fill_in "user_name", with: "User Name"
      fill_in "user_password", with: "test123"
      fill_in "user_password_confirmation", with: "test123"
      click_button "アカウント登録"
    }.to change(User, :count).by(1)

    expect(page).to have_content "アカウント登録が完了しました。"
    expect(current_path).to eq root_path
    # expect(page).to have_content "First Last"
  end
end
