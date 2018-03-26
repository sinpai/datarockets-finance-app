class BalanceTransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @balance_transaction = BalanceTransaction.new
    @balance_transaction.transactions.build
  end

  def create
    byebug
    respond_to do |format|
      notice = BalanceTransactions::Creator.new(create_params).call ? t('.success') : t('.failure')
      format.html { redirect_to transactions_path, notice: notice }
      format.js { render layout: false }
    end
  end

  def edit
    @balance_transaction = transaction.transactinable
  end

  def update
    byebug
    respond_to do |format|
      notice = BalanceTransactions::Updater.new(update_params).call ? t('.success') : t('.failure')
      format.html { redirect_to transactions_path, notice: notice }
      format.js { render layout: false }
    end
  end

  def destroy
    respond_to do |format|
      notice = BalanceTransactions::Destroyer.new(balance_transaction_params[:id]) ? t('.delete_success') : t('.failure')
      format.html { redirect_to transactions_path, notice: notice }
      format.js { render layout: false }
    end
  end

  private

  def balance_transaction_params
    params.require(:balance_transaction).permit(
      :id,
      :comment,
      :date,
      transactions: {}
    )
  end

  def params_to_hash
    {
      date: balance_transaction_params[:date],
      comment: balance_transaction_params[:comment],
      amount: balance_transaction_params[:transactions][:amount]
    }
  end

  def create_params
    params_to_hash.merge(user_id: current_user.id)
  end

  def update_params
    params_to_hash.merge(transaction_id: @balance_transaction.transactions.last.id)
  end

  def transaction
    @_transaction ||= Transaction.find(params[:id])
  end

  def balance_transaction
    @_balance_transaction ||= transaction.transactinable
  end
end
