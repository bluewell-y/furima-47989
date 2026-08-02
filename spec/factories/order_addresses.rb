FactoryBot.define do
  factory :order_address do
    postal_code   { '123-4567' }
    prefecture_id { 2 }
    city          { '東京都' }
    addresses     { '1-1' }
    building      { '東京ビル' }
    phone_number  { '09012345678' }
  end
end
