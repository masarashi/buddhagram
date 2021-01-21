class UsersController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: %i[index timeline]
  before_action :correct_user, only: :timeline
  before_action :admin?, only: :index

  def index
    @users = User.all
    # @pagy, @users = pagy(User.all)
  end

  def show
    @user = User.find(params[:id])
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
    @pagy, @feed_items = pagy(@user.feed, items: 3)
  end

  private

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user == @user
  end
end
