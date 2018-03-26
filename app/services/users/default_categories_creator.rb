class Users::DefaultCategoriesCreator < Struct.new(:user)
  def call
    default_categories_list.map do |name|
      categories.create(name: name, amount: 0, user_id: user.id)
    end
  end

  private

  def default_categories_list
    %w[Transportation Food House Entertainment Health Other]
  end

  delegate :categories, to: :user
end
