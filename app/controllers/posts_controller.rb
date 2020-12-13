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
    @spots_search_result = Spot.new
    @spot = Spot.find(params[:spot_id]) if params[:spot_id].present?
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

  # def add_spot
  #   # binding.pry
  #   @spot = Spot.find(params[:spot_id])
  # end

  def search
    @spot = Spot.new
    @search_keyword = params[:search_keyword]
    @spots_search_result = Spot.where(['name LIKE ? OR state LIKE ? OR address LIKE ?', "%#{@search_keyword}%", "%#{@search_keyword}%", "%#{@search_keyword}%"])
    # @name = params[:search_name]
    # @state = params[:search_state]
    # @spots_search_result = Spot.where(name: @name).or(Spot.where(state: @state))
  end

  private

    def post_params
      params.require(:post).permit(:content, :images, :spot_id).merge(user_id: current_user.id)
    end
end
