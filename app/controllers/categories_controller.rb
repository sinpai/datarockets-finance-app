class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: %i[update destroy edit show]
  before_action :set_parent, only: %i[new create]

  def index
    @categories = current_user.categories.top_category.paginate(page: params[:page], per_page: 10)
  end

  def show
    @transactions = current_user.transactions.category_history_transactions(params[:id].to_i)
    @subcategories = @category.sub_categories
  end

  def new
    @category = @parent.sub_categories.new
  end

  def create
    @category = Categories::Creator.new(parent: @parent, params: create_params).call
    respond_to do |format|
      if @category.present?
        flash[:notice] = t('.category_created')
      else
        flash[:alert] = t('.category_not_created')
      end
      format.html { redirect_to categories_path }
      format.js
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        flash[:notice] = t('.category_updated')
      else
        flash[:alert] = t('.category_not_updated')
      end
      format.html { redirect_to categories_path }
      format.js
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      flash[:notice] = t('.deleted_category_success')
      format.html { redirect_to categories_path }
      format.js
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def set_parent
    @parent ||= category || current_user
  end

  def category
    category_id = params[:category_id]
    current_user.categories.find_by(id: category_id) if category_id
  end

  def create_params
    category_params.merge(user_id: current_user.id)
  end

  def category_params
    params.require(:category).permit(
      :name,
      :amount
    )
  end
end
