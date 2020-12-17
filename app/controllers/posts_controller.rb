class PostsController < ApplicationController

  def index
    @posts = Post.with_attached_images.includes(:user, :spot, :comments).order(created_at: :desc)
    @like = Like.new
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

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to posts_path
    else
      render 'new'
    end

    # 投稿確認画面用（作成保留）
    # @post = Post.new(post_params)
    # if params[:back]
    #   render 'new'
    # else
    #   @post.save
    #   flash[:notice] = '投稿しました'
    #   redirect_to posts_path
    # end
  end

  # 投稿確認画面用（作成保留）
  # def confirm
  #   @post = Post.new(post_params)
  #   binding.pry
  #   render 'new' if @post.invalid?
  # end

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
    Post.find(params[:id]).destroy
    flash[:success] = '削除しました'
    redirect_to posts_path
  end

  def hashtag
    @hashtag = Hashtag.find_by(name: params[:name])
    @posts = @hashtag.posts
    @posts_count = @posts.count
  end

  def search
    @spot = Spot.new
    if params[:search_keyword].blank?
      @error_message = "キーワードを入力してください"
    else
      @search_keyword = params[:search_keyword]
      @spots_search_result = Spot.where(['name LIKE ? OR state LIKE ? OR address LIKE ?', "%#{@search_keyword}%", "%#{@search_keyword}%", "%#{@search_keyword}%"])
    end
  end

  private

    def post_params
      params.require(:post).permit(:content, :spot_id, images: []).merge(user_id: current_user.id)
    end
    
    def post_confirm_params
      # params.permit(:content, :spot_id, images: []).merge(user_id: current_user.id)
      params.require(:post).permit(:content, :spot_id, images: []).merge(user_id: current_user.id)
    end
end
