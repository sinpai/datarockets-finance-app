FactoryBot.define do
  factory :authorization do
    provider "github"
    uid { Faker::Omniauth.github['uid'] }
    user
  end
end
