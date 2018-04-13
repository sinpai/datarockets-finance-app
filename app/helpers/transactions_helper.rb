module TransactionsHelper
  def category_options
    options_for_select(categories_by_name_and_id)
  end

  private

  def categories_by_name_and_id
    current_user.categories.map { |category| [category.name, category.id] }
  end
end
