class Transaction < ApplicationRecord
  belongs_to :user

  validates :sum, :date, presence: true
  validates :sum, numericality: true

  scope :most_recent, -> { order(created_at: :desc).limit(most_recent_count) }

  def self.most_recent_count
    10
  end
end
