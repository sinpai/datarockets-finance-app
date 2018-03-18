class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, :date, presence: true
  validates :amount, numericality: true

  scope :most_recent, -> { order(created_at: :desc).limit(most_recent_count) }

  def self.most_recent_count
    10
  end
end
