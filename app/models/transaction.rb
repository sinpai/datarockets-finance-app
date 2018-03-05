class Transaction < ApplicationRecord
  belongs_to :user

  validates :sum, :date, presence: true
  validates :sum, numericality: true

  scope :most_recent ->{ order(created_at: :desc).limit(10) }

  def self.total(user)
    sum(:sum).where(user_id: user)
  end
end
