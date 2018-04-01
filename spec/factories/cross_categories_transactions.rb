FactoryBot.define do
  factory :cross_categories_transaction do
    association :category_from_id, factory: :category
    association :category_to_id, factory: :category
  end
end
