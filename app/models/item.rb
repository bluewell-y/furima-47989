class Item < ApplicationRecord
  # ユーザーとのアソシエーション
  belongs_to :user

  # 商品画像とのアソシエーション
  has_one_attached :image
end
