FactoryBot.define do
  factory :category do
    name { Faker::Lorem.words(2).join(' ') }
    amount { Faker::Number.decimal(2, 2).to_f }
    user

    trait :top_category do
      categorizable { |category| category.association(:user) }
    end

    trait :sub_category do
      categorizable { |category| category.association(:category) }
    end
  end
end
