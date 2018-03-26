class BalanceTransactions::Creator

  Args = Struct.new(:date, :comment, :amount, :user_id)

  def initialize(args)
    @args = Args.new(args[:date], args[:comment], args[:amount], args[:user_id])
  end

  def call
    ActiveRecord::Base.transaction do
      create_balance_transaction
      add_transaction_connection
    end
    @transaction
  end

  private

  def create_balance_transaction
    @transaction = BalanceTransaction.create(
      comment: @args.comment,
      date: @args.date
    )
  end

  def add_transaction_connection
    @transaction.transactions.create(amount: @args.amount, user_id: @args.user_id)
  end
end
