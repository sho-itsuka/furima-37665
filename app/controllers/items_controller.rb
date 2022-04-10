class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if user_signed_in?
      unless current_user == @item.user
        redirect_to root_path 
      end
    else  
      redirect_to new_user_session_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :price, :description, :image, :category_id, :item_status_id, :ship_cost_id,
                                 :ship_day_id, :ship_area_id).merge(user_id: current_user.id)
  end
end
