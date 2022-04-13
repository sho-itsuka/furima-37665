class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[index new create]

  def index
    @order_delivary = OrderDelivary.new
    redirect_to root_path if current_user == @item.user || !@item.order.nil?
  end

  def new
    @order_delivary = OrderDelivary.new
  end

  def create
    @order_delivary = OrderDelivary.new(order_params)
    if @order_delivary.valid?
      pay_item
      @order_delivary.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_delivary).permit(:postcode, :ship_area_id, :city, :block, :building, :phonenumber).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
