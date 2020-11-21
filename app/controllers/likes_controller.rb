class LikesController < ApplicationController

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_to request.referer
    # respond_to do |format|
    #   format.html { redirect_to request.referer }
    #   format.js
    # end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_to request.referer
    # respond_to do |format|
    #   format.html { redirect_to request.referer }
    #   format.js
    # end
  end
end
