class UsersController < ApplicationController
  include Pagy::Backend

  def show
    @user = User.find(params[:id])
    # @posts = @user.posts.with_attached_images.order(created_at: :desc)
    @pagy, @posts = pagy(@user.posts.with_attached_images.order(created_at: :desc), items: 9)
    @feed_items = @user.feed
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def timeline
    @user = User.find(params[:user_id])
    # @feed_items = @user.feed
    @pagy, @feed_items = pagy(@user.feed, items: 3)
  end
end
