FactoryBot.define do
  factory :category_transaction do
    category_id { rand(1000) }
  end
end
