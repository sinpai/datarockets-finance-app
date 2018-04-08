class Categories::Historier < Struct.new(:category)
  def result
    category_history
  end

  private

  def category_history
    result = []
    result << select_category_transaction
    result << select_cross_categories_transaction
  end

  def select_category_transaction
    user_category_transactions.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_id == category.id
    end
  end

  def select_cross_categories_transaction
    user_cross_categories_transactions.includes(:transactinable).select do |transaction|
      transactinable = transaction.transactinable
      transactinable.category_from_id == id || transactinable.category_to_id == id
    end
  end

  delegate :category_transactions, :cross_categories_transactions, to: :user, prefix: true
  delegate :id, :user, to: :category
end
