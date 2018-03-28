class BalanceTransactions::Destroyer < Struct.new(:id)
  def call
    destroy_balance_transaction
    destroy_transaction
  end

  private

  def destroy_balance_transaction
    transaction.transactinable.destroy
  end

  def transaction
    @_transaction = Transaction.find(id)
  end

  def destroy_transaction
    @_transaction.destroy
  end
end
