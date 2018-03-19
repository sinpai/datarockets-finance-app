FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    amount { Faker::Number.digit.to_i }
    user
  end
end
