class StatuesController < ApplicationController
  before_action :admin?, only: %i[new create edit update destroy]

  def index
    @statues = Statue.with_attached_image
    @nyorai = Statue.with_attached_image.where(grade: '如来')
    @bosatsu = Statue.with_attached_image.where(grade: '菩薩')
    @myouou = Statue.with_attached_image.where(grade: '明王')
    @tenbu = Statue.with_attached_image.where(grade: '天部')
    @others = Statue.with_attached_image.where(grade: 'その他')
  end

  def show
    @statue = Statue.find(params[:id])
  end

  def new
    @spots = Spot.all
    @statue = Statue.new
    @statue.storehouses.new
  end

  def create
    @statue = Statue.new(statue_params)
    if @statue.save!
      flash[:notice] = '登録しました'
      redirect_to @statue
    else
      render 'new'
    end
  end

  def edit
    @spots = Spot.all
    @statue = Statue.find(params[:id])
  end

  def update
    @statue = Statue.find(params[:id])
    if @statue.update(statue_params)
      flash[:notice] = '更新しました'
      redirect_to @statue
    else
      render 'edit'
    end
  end

  def destroy
    Statue.find(params[:id]).destroy!
    flash[:notice] = '削除しました'
    redirect_to statues_path
  end

  private

  def statue_params
    params.require(:statue).permit(:name, :ruby, :grade, :content, :image, spot_ids: [])
  end
end
