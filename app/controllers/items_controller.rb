class ItemsController < ApplicationController
  # ログインしていないユーザーが、出品・編集・更新などのログイン必須ページにアクセスした際、自動的にログイン画面へリダイレクトする
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  # show, edit, updateアクションが実行される前に、リクエストされたIDの商品情報をDBから取得して @item に代入する
  before_action :set_item, only: [:show, :edit, :update]
  # ログイン中のユーザーが出品者本人でない場合、商品の編集・更新ページへのアクセスを拒否してトップページへリダイレクトする
  before_action :contributor_confirmation, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
