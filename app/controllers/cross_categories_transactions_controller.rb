class CrossCategoriesTransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @categories = current_user.categories
  end

  def create
    respond_to do |format|
      notice = if CrossCategoriesTransactions::Creator.new(create_params).call
        t('.success')
      else
        t('.failure')
      end
      format.html { redirect_to categories_path, notice: notice }
      format.js { render layout: false }
    end
  end

  private

  def create_params
    {
      user_id: current_user.id,
      category_from_id: cross_categories_params[:category_from_id],
      category_to_id: cross_categories_params[:category_to_id],
      amount: cross_categories_params[:amount].to_f
    }
  end

  def cross_categories_params
    params.require(:cross_categories_transaction).permit(
      :amount,
      :category_from_id,
      :category_to_id
    )
  end
end
