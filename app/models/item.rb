class Item < ApplicationRecord
  # ユーザーとのアソシエーション
  belongs_to :user

  # 商品画像とのアソシエーション
  has_one_attached :image

  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # すべての項目の入力が必須
  validates :image,                  presence: true
  validates :name,                   presence: true
  validates :info,                   presence: true
  validates :price,                  presence: true

  # ActiveHashの選択が「---」の時は保存できないようにする
  validates :category_id,            numericality: { other_than: 1, message: "can't be blank" }
  validates :sales_status_id,        numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :scheduled_delivery_id,  numericality: { other_than: 1, message: "can't be blank" }

  # 価格（Price）に関する制限
  # 半角数値のみ（only_integer: true）
  # ¥300 〜 ¥9,999,999 の範囲のみ保存可能
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }
end
