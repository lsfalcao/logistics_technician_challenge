FactoryBot.define do
  factory :order do
    date { Faker::Date.between(from: 6.months.ago, to: Date.current) }
    user
  end
end
