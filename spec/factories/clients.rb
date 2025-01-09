FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
  end
end
