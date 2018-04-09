module TransactionsHelper
  def category_options
    options_for_select(current_user.categories.map { |category| [category.name, category.id] }) || []
  end
end
