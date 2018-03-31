class BalanceTransactions::Updater
  def initialize(date:, comment:, amount:, transaction_id:)
    @date = date
    @comment = comment
    @amount = amount
    @transaction_id = transaction_id
  end

  def call
    ActiveRecord::Base.transaction do
      update_balance_transaction
      update_transaction_data
    end
  end

  private

  def update_balance_transaction
    transaction.transactinable.update(
      comment: @comment,
      date: @date
    )
  end

  def update_transaction_data
    @transaction.update(amount: @amount)
  end

  def transaction
    @transaction = Transaction.find(@transaction_id)
  end
end
