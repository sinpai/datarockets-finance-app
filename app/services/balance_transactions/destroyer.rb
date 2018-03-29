class BalanceTransactions::Destroyer < Struct.new(:id)
  def call
    destroy_transaction
  end

  private

  def transaction
    Transaction.find(id)
  end

  def destroy_transaction
    transaction.destroy
  end
end
