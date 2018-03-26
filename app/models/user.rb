class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 github]

  has_many :transactions, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :categories, dependent: :destroy

  def balance
    transactions.sum(:amount).to_i
  end
end
