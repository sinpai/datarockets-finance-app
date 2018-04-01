class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: %i[update destroy edit category_history]

  def index
    @categories = current_user.categories.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    respond_to do |format|
      if @category.save
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

  def category_history
    @transactions = current_user.transactions.category_history_transactions(params[:id].to_i)
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(
      :name,
      :amount
    )
  end
end
