class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    # 自身が出品した商品 または 売却済みの商品 の場合はトップページへ遷移
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    @order_address = OrderAddress.new
  end

  def create
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
