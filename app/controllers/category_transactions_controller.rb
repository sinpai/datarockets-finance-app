class CategoryTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_form, only: %i[new create]

  def new
  end

  def create
    respond_to do |format|
      notice = create_conditions
      format.html { redirect_to categories_path, notice: notice }
      format.js { render layout: false }
    end
  end

  private

  def create_conditions
    category_transaction = CategoryTransactions::Creator.new(create_params).call
    if @form.validate(category_transaction_params) &&
       category_transaction
      t('.success')
    elsif category_transaction == -1
      t('.negative_amount')
    else
      t('.failure')
    end
  end

  def create_new_form
    @form = CategoryTransactionForm.new(current_user.transactions.new)
  end

  def create_params
    {
      user_id: current_user.id,
      category_id: params[:id],
      amount: category_transaction_params[:amount].to_f
    }
  end

  def category_transaction_params
    params.require(:transaction).permit(
      :amount
    )
  end
end
