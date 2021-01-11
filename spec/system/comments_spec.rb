require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'user adds comment to post' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    sign_in user
    visit post_path(post)

    expect do
      fill_in 'comment_content', with: 'Test Comment'
      click_on '送信'

      expect(page).to have_content 'Test Comment'
      expect(page).to have_content 'コメントしました'
      expect(page).to have_content user.name.to_s
    end.to change(post.comments, :count).by(1)
  end

  it 'user deletes own comment' do
    comment = FactoryBot.create(:comment)

    sign_in comment.user
    visit post_path(comment.post)

    expect do
      click_link '削除'
      expect(page.accept_confirm).to eq '本当に削除しますか？'
      expect(page).to have_content 'コメントを削除しました'
    end.to change(comment.post.comments, :count).by(-1)
  end
end
