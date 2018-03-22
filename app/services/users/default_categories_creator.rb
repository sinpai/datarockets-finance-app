class Users::DefaultCategoriesCreator < Struct.new(:user)
  def call
    default_categories_list.map { |name| create_category(name) }
  end

  private

  def create_category(name)
    user.categories.create(name: name, amount: 0, user_id: user.id)
  end

  delegate :categories, to: :user

  def default_categories_list
    %w[Transportation Food House Entertainment Health Other]
  end
end
