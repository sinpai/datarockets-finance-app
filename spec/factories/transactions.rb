require 'faker'

FactoryBot.define do
  factory :transaction do
    amount { Random.rand(100) }
    date '2018-03-05'
    comment { Faker::Lorem.sentence }
    user
  end
end
