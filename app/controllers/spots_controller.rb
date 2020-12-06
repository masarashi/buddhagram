class SpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def search_location
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    @locations = Spot.within_box(1000, latitude, longitude)
    gon.locations = @locations
  end
end
