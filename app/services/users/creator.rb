class Users::Creator < Struct.new(:email)
  def call
    create_user
    add_default_categories
  end

  private

  def create_user
    @user = User.create(
      email: email,
      password: Devise.friendly_token[0, 20],
      confirmed_at: Date.current
    )
  end

  def add_default_categories
    Users::DefaultCategoriesCreator.new(@user).call
    @user
  end
end
