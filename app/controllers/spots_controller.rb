class SpotsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :admin?, only: %i[new create edit update destroy geocoding_search]

  def index
    @spots = Spot.with_attached_image
    # @spots_search_result = Spot.new
  end

  def show
    @spot = Spot.find(params[:id])
    @posts = @spot.posts.order(created_at: :desc)
    @popular_posts = @posts.limit(6).sort { |a, b| b.likes.count <=> a.likes.count }
    @pagy, @latest_posts = pagy(@posts, items: 3)
  end

  def new
    @spot = Spot.new
    @name = params[:search_name]
    @results = Geocoder.search(@name.to_s)
    @country = @results.first.country
    @state = @results.first.state
    @address = @results.first.address.tr('、', ' ').split(' ')[1, 2].join(' ')
    @latitude = @results.first.latitude
    @longitude = @results.first.longitude
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      flash[:notice] = '登録しました'
      redirect_to @spot
    else
      render 'new'
    end
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      flash[:notice] = '更新しました'
      redirect_to @spot
    else
      render 'edit'
    end
  end

  def destroy
    Spot.find(params[:id]).destroy!
    flash[:notice] = '削除しました'
    redirect_to spots_path
  end

  def geocoding_search
    @spot = Spot.new
  end

  def search_location
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @current_location = Spot.new(name: '現在地', latitude: @latitude, longitude: @longitude)
    @locations = @current_location.nearbys(200, units: :km).with_attached_image
    gon.locations = @locations

    # Google Map
    # @locations = Spot.within_box(200, @latitude, @longitude)
  end

  def search
    @spot = Spot.new
    if params[:search_keyword].blank?
      @error_message = '検索ワードを入力してください'
    else
      @search_keyword = params[:search_keyword]
      @users_search_result = User.where(['name LIKE ?', "%#{@search_keyword}%"])
      @hashtags_search_result = Hashtag.where(['name LIKE ?', "%#{@search_keyword}%"])
      @spots_search_result = Spot.where(['name LIKE ? OR state LIKE ? OR address LIKE ?', "%#{@search_keyword}%",
                                         "%#{@search_keyword}%", "%#{@search_keyword}%"])
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :country, :state, :address, :latitude, :longitude, :image)
  end
end
