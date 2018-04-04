class Category < ApplicationRecord
  belongs_to :user
  has_many :category_transactions, dependent: :destroy
  has_many :categories_from, class_name: 'CrossCategoriesTransaction',
                             foreign_key: 'category_from',
                             dependent: :destroy
  has_many :categories_to, class_name: 'CrossCategoriesTransaction',
                           foreign_key: 'category_to',
                           dependent: :destroy
  belongs_to :categorizable, polymorphic: true, optional: true
  has_many :sub_categories, as: :categorizable, dependent: :destroy, class_name: 'Category'

  scope :top_category, -> { where(categorizable_type: 'User').order(created_at: :asc) }

  validates :amount, :name, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}
  validates :name, length: {minimum: 2, maximum: 15}
end
