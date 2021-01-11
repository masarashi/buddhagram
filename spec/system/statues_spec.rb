require 'rails_helper'

RSpec.describe 'Statues', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'admin creates the statue' do
    admin = FactoryBot.create(:user, :admin)
    spot = FactoryBot.create(:spot)

    sign_in admin
    visit new_statue_path

    fill_in 'statue_name', with: '釈迦如来'
    fill_in 'statue_ruby', with: 'しゃかにょらい'
    select '如来', from: 'Grade'
    fill_in 'statue_content', with: 'テスト'
    check spot.name
    click_on '登録'
    expect(page).to have_content '登録しました'
    expect(page).to have_content '釈迦如来'
  end

  it 'admin edits the statue' do
    admin = FactoryBot.create(:user, :admin)
    statue = FactoryBot.create(:statue, :with_spots)

    sign_in admin
    visit statue_path(statue)

    click_on '編集'
    fill_in 'statue_name', with: '弥勒菩薩'
    fill_in 'statue_ruby', with: 'みろくぼさつ'
    select '菩薩', from: 'Grade'
    fill_in 'statue_content', with: '編集テスト'
    uncheck statue.spots[0].name
    click_on '更新'

    expect(page).to have_content '弥勒菩薩'
    expect(page).to have_content 'みろくぼさつ'
    expect(page).to have_content '菩薩'
    expect(page).to have_content '編集テスト'
    expect(page).to have_content '更新しました'
    expect(page).to have_no_content statue.spots[0].name
  end

  it 'admin deletes the statue' do
    admin = FactoryBot.create(:user, :admin)
    statue = FactoryBot.create(:statue)

    sign_in admin
    visit statue_path(statue)
    click_on '編集'
    click_on '削除'

    expect(page.accept_confirm).to eq '本当に削除しますか？'
    expect(page).to have_content '削除しました'
  end

  it 'statues are in the spot' do
    statue = FactoryBot.create(:statue, :with_spots)

    visit statue_path(statue)

    expect(page).to have_selector 'a', text: statue.spots[0].name
  end
end
