class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:index, :create]
  before_action :check_owner, only: [:index, :create]
  before_action :check_order, only: [:index, :create]
  

  def index
    @order = OrderAddress.new
  end

  def create
    @order = OrderAddress.new(order_address_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render "orders/index"
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_owner
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end
  end

  def check_order
    if @item.order.present? || @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def order_address_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipality, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    set_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: set_item[:price],
      card: order_address_params[:token],
      currency:'jpy'
    )
  end
end