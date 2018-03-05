FactoryBot.define do
  factory :transaction do
    sum 'MyString'
    date '2018-03-05'
    comment 'MyString'
    user nil
  end
end
