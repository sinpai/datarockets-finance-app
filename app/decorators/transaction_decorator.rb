class TransactionDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def category_name
    deleted_category = I18n.t('.deleted_category')
    transactinable.try(:category).try(:name) ||
      (transactinable.try(:category_from).try(:name) || deleted_category) +
        '-> ' + (transactinable.try(:category_to).try(:name) || deleted_category)
  end

  def date
    transactinable.try(:date) || transactinable.created_at.strftime('%Y-%m-%d')
  end

  def comment
    transactinable.try(:comment) || I18n.t('.moving_to') + category_name
  end
end
