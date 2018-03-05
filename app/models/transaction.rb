class Transaction < ApplicationRecord
  belongs_to :user

  validates :sum, :date, presence: true
  validates :sum, numericality: true

  scope :most_recent, ->(user) { where(user_id: user).order(created_at: :desc).limit(10) }
  scope :total, ->(user) { sum(:sum).where(user_id: user) }
end
