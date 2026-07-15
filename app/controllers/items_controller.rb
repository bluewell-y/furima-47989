class ItemsController < ApplicationController
  # ログインしていないユーザーがnew（出品画面）にアクセスしたら、ログイン画面へリダイレクトする
  before_action :authenticate_user!, only: [:new]

  def new
    @item = Item.new
  end
end
