class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transactinable, dependent: :destroy, polymorphic: true, optional: true

  validates :amount, :user, presence: true
  validates :amount, numericality: true
  validates :amount, numericality: {greater_than: 0}

  scope :most_recent, -> { order(created_at: :desc).limit(most_recent_count) }

  scope :balance_transactions, -> { where(transactinable_type: 'BalanceTransaction') }
  scope :category_transactions, -> { where(transactinable_type: 'CategoryTransaction') }
  scope :cross_categories_transactions, -> { where(transactinable_type: 'CrossCategoriesTransaction') }

  def self.category_history_transactions(id)
    where.not(transactinable_type: 'BalanceTransaction').select do |ar_trans|
      ar_transactinable = ar_trans.transactinable
      if ar_transactinable.is_a?(CategoryTransaction)
        ar_transactinable.category_id.eql?(id)
      else
        ar_transactinable.category_to_id.eql?(id)
      end
    end
  end

  def self.most_recent_count
    10
  end

  def balance_transaction?
    transactinable.is_a?(BalanceTransaction)
  end

  def category_comment
    transactinable.try(:category).try(:name) ||
      transactinable.category_from.name + '-> ' + transactinable.category_to.name
  end

  def created_time
    created_at.strftime('%Y-%m-%d')
  end
end
