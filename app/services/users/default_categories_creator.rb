class Users::DefaultCategoriesCreator < Struct.new(:user)
  def call
    default_categories_list.map do |name|
      Category.create(name: name, amount: 0, user_id: user.id, categorizable: user)
    end
  end

  private

  def default_categories_list
    %w[Transportation Food House Entertainment Health Other]
  end

  delegate :categories, to: :user
end
