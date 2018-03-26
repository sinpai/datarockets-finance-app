FactoryBot.define do
  factory :authorization do
    provider { @w[github google].sample }
    uid { Faker::Omniauth.github['uid'] }
    user
  end
end
