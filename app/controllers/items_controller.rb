class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit destroy]
  before_action :set_item, only: %i[edit show update destroy]
  before_action :require_permission, only: %i[edit destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path unless @item.order.nil?
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:title, :price, :description, :image, :category_id, :item_status_id, :ship_cost_id,
                                 :ship_day_id, :ship_area_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def require_permission
    redirect_to root_path unless current_user == @item.user
  end
end
