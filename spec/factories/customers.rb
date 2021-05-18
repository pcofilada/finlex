FactoryBot.define do
  factory :customer do
    name    { Faker::Name.name }
    address { Faker::Address.full_address }
    email   { Faker::Internet.email }
  end
end
