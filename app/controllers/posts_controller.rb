class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:info] = '投稿しました'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(shop_params)
      flash[:success] = '更新しました'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = '削除しました'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
