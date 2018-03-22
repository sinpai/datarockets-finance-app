FactoryBot.define do
  factory :balance_transaction do
    comment { Faker::Lorem.sentence }
    date { Time.current }
  end
end
