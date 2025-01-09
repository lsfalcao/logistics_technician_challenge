FactoryBot.define do
  factory :legacy_order_import do
    client
    file { File.open("#{Rails.root}/public/desafio/data_1.txt") }
  end
end
