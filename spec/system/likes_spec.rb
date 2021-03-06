require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  it 'user like and unlike to post on show page', js: true do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    sign_in user
    visit post_path(post)

    expect do
      find('.likes-link').click
      sleep 0.5
    end.to change(post.likes, :count).by(1)

    expect do
      find('.likes-link').click
      sleep 0.5
    end.to change(post.likes, :count).by(-1)
  end

  it 'user like and unlike to post on timeline', js: true do
    post = FactoryBot.create(:post)

    sign_in post.user
    visit user_timeline_path(post.user)

    expect do
      find('.likes-link').click
      sleep 0.5
    end.to change(post.likes, :count).by(1)

    expect do
      find('.likes-link').click
      sleep 0.5
    end.to change(post.likes, :count).by(-1)
  end
end
