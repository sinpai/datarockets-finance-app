class BalanceTransaction < ApplicationRecord
  validates :comment, length: {maximum: 80}
  validates :date, presence: true

  has_many :transactions, as: :transactinable, dependent: :destroy
end
