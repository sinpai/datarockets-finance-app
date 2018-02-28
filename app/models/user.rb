class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :confirmable, :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :github]
end
