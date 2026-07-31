class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選んでください' }
    validates :city
    validates :addresses
    validates :phone_number
  end

  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は『3桁ハイフン4桁』の半角数字で入力してください' }, allow_blank: true
  validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'は10桁以上11桁以内の半角数字（ハイフンなし）で入力してください' }, allow_blank: true

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
