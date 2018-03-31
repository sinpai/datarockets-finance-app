require 'faker'

FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.digit.to_i }
    user

    trait :balance_transactions do
      transactinable { |transaction| transaction.association(:balance_transaction) }
    end

    trait :category_transactions do
      transactinable { |transaction| transaction.association(:category_transaction) }
    end
  end
end
