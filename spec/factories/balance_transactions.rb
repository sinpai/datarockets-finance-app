FactoryBot.define do
  factory :balance_transaction do
    comment { Faker::Lorem.word }
    date { Time.current }
  end
end
