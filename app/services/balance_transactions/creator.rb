class BalanceTransactions::Creator
  def initialize(date:, comment:, amount:, user_id:)
    @date = date
    @comment = comment
    @amount = amount.to_f
    @user_id = user_id
  end

  def call
    ActiveRecord::Base.transaction do
      create_balance_transaction
      add_transaction_connection
    end
  end

  private

  def create_balance_transaction
    @transaction = BalanceTransaction.create(
      comment: @comment,
      date: @date
    )
  end

  def add_transaction_connection
    @transaction.transactions.create(amount: @amount, user_id: @user_id)
  end
end
