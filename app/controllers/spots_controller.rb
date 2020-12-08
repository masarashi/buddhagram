class SpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def new
    @spot = Spot.new
    @name = params[:search_name]
    @results = Geocoder.search("#{@name}")
    @country = @results.first.country
    @state = @results.first.state
    @address = @results.first.address.gsub("、"," ").split(" ")[1,2].join(' ')
    # @address1 = @results.first.address.gsub("、"," ").split(" ")[1]
    # @address2 = @results.first.address.gsub("、"," ").split(" ")[2]
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

  def get_address
    @spot = Spot.new
    # @name = params[:search_name]
    # @results = Geocoder.search("#{@name}")
    # @state = @results.first.state
    # @address = @results.first.address.gsub("、"," ").split(" ")
  end

  def search_location
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    @locations = Spot.within_box(1000, latitude, longitude)
    gon.locations = @locations
  end

  private

    def spot_params
      params.require(:spot).permit(:name, :country, :state, :address, :latitude, :longitude)
    end
end
