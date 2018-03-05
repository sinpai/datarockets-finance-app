class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 github]

  has_many :transactions, dependent: :destroy
end
