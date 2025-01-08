FactoryBot.define do
  factory :order_product do
    value { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    product_id { Faker::Number.number(digits: 4) }
    order
  end
end
