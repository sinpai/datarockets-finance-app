class Category < ApplicationRecord
  belongs_to :user
  has_many :category_transactions, dependent: :destroy

  validates :amount, :name, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}
  validates :name, length: {maximum: 15}
end
