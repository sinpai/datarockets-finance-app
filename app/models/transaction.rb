class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transactinable, dependent: :destroy, polymorphic: true, optional: true

  validates :amount, :user, presence: true
  validates :amount, numericality: true

  scope :most_recent, -> { order(created_at: :desc).limit(most_recent_count) }

  def self.most_recent_count
    10
  end
end
