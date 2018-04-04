require 'faker'

FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.decimal(3, 2).to_f }
    user

    trait :balance_transactions do
      transactinable { |transaction| transaction.association(:balance_transaction) }
    end

    trait :category_transactions do
      transactinable { |transaction| transaction.association(:category_transaction) }
    end

    trait :cross_categories_transactions do
      transactinable { |transaction| transaction.association(:cross_categories_transaction) }
    end
  end
end
