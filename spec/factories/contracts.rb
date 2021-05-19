FactoryBot.define do
  factory :contract do
    price       { Faker::Number.decimal(l_digits: 2) }
    start_date  { Faker::Date.forward(days: 1) }
    end_date    { Faker::Date.forward(days: 15) }
    expiry_date { Faker::Date.forward(days: 30) }

    customer    { association :customer }
  end
end
