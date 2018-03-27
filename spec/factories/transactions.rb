require 'faker'

FactoryBot.define do
  factory :transaction do
    transactinable { |transaction| transaction.association(:balance_transaction) }
    amount { Faker::Number.digit.to_i }
    user
  end
end
