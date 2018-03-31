class BalanceTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_form, only: %i[new create]
  before_action :create_edit_form, only: %i[edit update]

  def new
  end

  def create
    respond_to do |format|
      notice = if @form.validate(balance_transaction_params) &&
                  BalanceTransactions::Creator.new(create_params).call
        t('.success')
      else
        t('.failure')
      end
      format.html { redirect_to transactions_path, notice: notice }
      format.js { render layout: false }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      notice = if @form.validate(balance_transaction_params) &&
                  BalanceTransactions::Updater.new(update_params).call
        t('.success')
      else
        t('.failure')
      end
      format.html { redirect_to transactions_path, notice: notice }
      format.js { render layout: false }
    end
  end

  def destroy
    respond_to do |format|
      notice = if BalanceTransactions::Destroyer.new(params[:id]).call
        t('.delete_success')
      else
        notice = t('.failure')
      end
      format.html { redirect_to transactions_path, notice: notice }
      format.js { render layout: false }
    end
  end

  private

  def create_params
    params_to_hash.merge(user_id: current_user.id)
  end

  def update_params
    params_to_hash.merge(transaction_id: balance_transaction.transactions.last.id)
  end

  def params_to_hash
    {
      date: balance_transaction_params[:date],
      comment: balance_transaction_params[:comment],
      amount: balance_transaction_params[:transactions_attributes][:amount]
    }
  end

  def balance_transaction_params
    params.require(:balance_transaction).permit(
      :id,
      :comment,
      :date,
      transactions_attributes: %i[id amount]
    )
  end

  def create_new_form
    @form = BalanceTransactionForm.new(BalanceTransaction.new, transactions: Transaction.new)
  end

  def create_edit_form
    @form = BalanceTransactionForm.new(balance_transaction, transactions: transaction)
  end

  def transaction
    @_transaction = @_balance_transaction.transactions.last || Transaction.find(params[:id])
  end

  def balance_transaction
    @_balance_transaction = BalanceTransaction.find(params[:id]) || transaction.transactinable
  end
end
