FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    amount { Faker::Number.decimal(2, 2).to_f }
    user
  end
end
