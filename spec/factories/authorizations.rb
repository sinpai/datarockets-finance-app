FactoryBot.define do
  factory :authorization do
    provider { rand(2) == 1 ? 'github' : 'google' }
    uid { Faker::Omniauth.github['uid'] }
    user
  end
end
