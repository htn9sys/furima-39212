class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    # @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :category_id, :condition_id, :postage_id, :sender_id, :prefecture_id, :explanation, :price, :user_id, :image).merge(user_id: current_user.id)
  end
  
end