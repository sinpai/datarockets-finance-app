class CategoryTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: :new

  def new
  end

  def create
    respond_to do |format|
      notice = if CategoryTransactions::Creator.new(create_params).call
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
      category_id: params[:id],
      amount: category_transaction_params[:amount].to_f
    }
  end

  def category_transaction_params
    params.require(:category_transaction).permit(
      :amount
    )
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
