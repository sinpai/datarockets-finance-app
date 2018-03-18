require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    confirmed_at { Time.current }
  end
end
