class Categories::Creator
  def initialize(parent:, params:)
    @parent = parent
    @name = params[:name]
    @user_id = params[:user_id]
  end

  def call
    @parent.sub_categories.create(name: @name, user_id: @user_id, amount: 0)
  end
end
