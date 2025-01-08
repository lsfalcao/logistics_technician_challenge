# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if User.count.zero?
  50.times do
    params = {
      name: Faker::Name.name,
      orders_attributes: [{
        date: Faker::Date.between(from: 6.months.ago, to: Date.current),
        order_products_attributes: [{
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          product_id: Faker::Number.number(digits: 4)
        }, {
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          product_id: Faker::Number.number(digits: 4)
        }]
      }, {
        date: Faker::Date.between(from: 6.months.ago, to: Date.current),
        order_products_attributes: [{
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          product_id: Faker::Number.number(digits: 4)
        }, {
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          product_id: Faker::Number.number(digits: 4)
        }, {
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          product_id: Faker::Number.number(digits: 4)
        }]
      }]
    }
    User.create(params)
  end
end
