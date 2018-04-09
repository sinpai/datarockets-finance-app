class CategoryDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def full_amount
    amount + sub_categories.sum(&:amount)
  end
end
