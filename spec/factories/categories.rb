FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    amount { Faker::Number.digit.to_f }
    user

    trait :top_category do
      categorizable { |category| category.association(:user) }
    end

    trait :sub_category do
      categorizable { |category| category.association(:category) }
    end
  end
end
