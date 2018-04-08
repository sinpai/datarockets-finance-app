class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transactinable, dependent: :destroy, polymorphic: true, optional: true

  validates :amount, :user, presence: true
  validates :amount, numericality: true
  validates :amount, numericality: {greater_than: 0}

  scope :most_recent, -> { order(created_at: :desc).limit(most_recent_count) }

  scope :balance_transactions, -> { where(transactinable_type: 'BalanceTransaction') }
  scope :category_transactions, -> { where(transactinable_type: 'CategoryTransaction') }

  def self.most_recent_count
    10
  end

  def balance_transaction?
    transactinable.is_a?(BalanceTransaction)
  end
end
