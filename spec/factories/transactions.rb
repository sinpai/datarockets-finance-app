require 'faker'

FactoryBot.define do
  factory :transaction do
    transactinable { |transaction| transaction.association(:balance_transaction) }
    amount { Random.rand(100) }
    user
  end
end
