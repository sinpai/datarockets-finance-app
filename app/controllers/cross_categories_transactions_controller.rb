class CrossCategoriesTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_form, only: %i[new create]

  def new
    @categories = current_user.categories
  end

  def create
    respond_to do |format|
      notice = if @form.validate(transaction_params) &&
                  CrossCategoriesTransactions::Creator.new(create_params).call
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
      category_from_id: cross_categories_transactions_params[:category_from_id],
      category_to_id: cross_categories_transactions_params[:category_to_id],
      amount: transaction_params[:amount].to_f
    }
  end

  def cross_categories_transactions_params
    transaction_params[:cross_categories_transactions_attributes]
  end

  def create_new_form
    @form = CrossCategoriesTransactionForm.new(
      current_user.transactions.new,
      cross_categories_transactions: CrossCategoriesTransaction.new
    )
  end

  def transaction_params
    params.require(:transaction).permit(
      :amount,
      cross_categories_transactions_attributes: %i[category_from_id category_to_id]
    )
  end
end
