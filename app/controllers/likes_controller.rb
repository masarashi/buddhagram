class LikesController < ApplicationController
  before_action :post_params
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  private

  def post_params
    @post = Post.find(params[:post_id])
  end
end
