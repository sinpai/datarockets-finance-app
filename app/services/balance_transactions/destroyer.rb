class BalanceTransactions::Destroyer < Struct.new(:transaction_id)

  def call
    destroy_transaction
  end

  private

  def destroy_balance_transaction
    transaction.transactionable.destroy
  end

  def transaction
    @_transaction = Transaction.find(@params[:transaction_id])
  end

  def destroy_transaction
    @_transaction.destroy
  end
end
