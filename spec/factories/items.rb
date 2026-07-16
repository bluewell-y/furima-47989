FactoryBot.define do
  factory :item do
    name                   { Faker::Name.name }
    info                   { Faker::Lorem.sentence }
    category_id            { 2 }
    sales_status_id        { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id          { 2 }
    scheduled_delivery_id  { 2 }
    price                  { 500 }
    association :user

    # 画像を添付する処理
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('public/images/test_image.png')), filename: 'test_image.png',
                        content_type: 'image/png')
    end
  end
end
