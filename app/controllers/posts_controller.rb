class PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
    @like = Like.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
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

  def hashtag
    @hashtag = Hashtag.find_by(name: params[:name])
    @posts = @hashtag.posts
    @posts_count = @posts.count
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end
end
