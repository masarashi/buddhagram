class SearchController < ApplicationController
  def index
    @spots = Spot.all
    @spots_search_result = Spot.new
  end

  def search
    @spot = Spot.new
    if params[:search_keyword].blank?
      @error_message = "キーワードを入力してください"
    else
      @search_keyword = params[:search_keyword]
      @users_search_result = User.where(['name LIKE ?', "%#{@search_keyword}%"])
      @hashtags_search_result = Hashtag.where(['name LIKE ?', "%#{@search_keyword}%"])
      @spots_search_result = Spot.where(['name LIKE ? OR state LIKE ? OR address LIKE ?', "%#{@search_keyword}%", "%#{@search_keyword}%", "%#{@search_keyword}%"])
      @statues_search_result = Statue.where(['name LIKE ? OR ruby LIKE ? OR grade LIKE ? OR content LIKE ?', "%#{@search_keyword}%", "%#{@search_keyword}%", "%#{@search_keyword}%", "%#{@search_keyword}%"])
    end
  end
end
