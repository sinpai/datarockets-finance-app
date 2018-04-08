class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable
  devise :omniauthable, omniauth_providers: %i[google github]

  has_many :transactions, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :categories, dependent: :destroy

  def balance
    transactions.balance_transactions.sum(:amount).to_f
  end

  def free_balance
    balance - categories.sum(:amount)
  end

  delegate :category_transactions, to: :transactions
  delegate :cross_categories_transactions, to: :transactions
end
