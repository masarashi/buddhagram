class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    flash[:notice] = 'コメントしました' if @comment.save
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find_by(id: params[:id])
    @comment.destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to @post
  end

  private

    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_path if @comment.nil?
    end
end
