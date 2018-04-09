class CategoryDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def full_amount
    self_and_descendents.map(&:amount).flatten.reduce(0, :+)
  end
end
