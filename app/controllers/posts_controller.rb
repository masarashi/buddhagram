class PostsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: %i[index new new_post create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :admin?, only: :index

  def index
    @pagy, @posts = pagy(Post.includes(:user).order(created_at: :desc))
  end

  def show
    @post = Post.with_attached_images.find(params[:id])
    @comments = Comment.includes(user: [image_attachment: :blob]).where(post_id: @post.id)
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @spots_search_result = Spot.new
    @spot = Spot.find(params[:spot_id]) if params[:spot_id].present?
  end

  def new_post
    @post = Post.new
    @spots_search_result = Spot.new
    @spot = Spot.find(params[:spot_id]) if params[:spot_id].present?
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to user_timeline_path(@post.user)
    else
      render 'new'
    end
  end

  def edit
    @post = Post.with_attached_images.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end

    if @post.update(post_params)
      flash[:success] = '更新しました'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy!
    flash[:notice] = '投稿を削除しました'
    redirect_to user_timeline_path(@post.user)
  end

  def hashtag
    @hashtag = Hashtag.find_by(name: params[:name])
    if @hashtag
      @posts = @hashtag.posts.order(created_at: :desc)
      @popular_posts = @posts.limit(6).sort { |a, b| b.likes.count <=> a.likes.count }
      @pagy, @latest_posts = pagy(@posts, items: 9)
      @posts_count = @posts.count
    else
      redirect_to root_path
    end
  end

  def search
    @spot = Spot.new
    if params[:search_keyword].blank?
      @error_message = '検索ワードを入力してください'
    else
      @search_keyword = params[:search_keyword]
      @spots_search_result = Spot.where(['name LIKE ? OR state LIKE ? OR address LIKE ?', "%#{@search_keyword}%",
                                         "%#{@search_keyword}%", "%#{@search_keyword}%"])
    end
  end

  def latest
    @posts = Post.all.order(created_at: :desc)
    @pagy, @latest_posts = pagy(@posts, items: 3)
  end

  private

  def post_params
    params.require(:post).permit(:content, :spot_id, images: []).merge(user_id: current_user.id)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
