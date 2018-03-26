class BalanceTransactions::Updater

  Args = Struct.new(:date, :comment, :amount, :transaction_id)

  def initialize(args)
    @args = Args.new(args[:date], args[:comment], args[:amount], args[:transaction_id])
  end

  def call
    ActiveRecord::Base.transaction do
      update_balance_transaction
      update_transaction_data
    end
    @transaction
  end

  private

  def update_balance_transaction
    transaction.transactionable.update(
      comment: @args.comment,
      date: @args.date
    )
  end

  def transaction
    @_transaction = Transaction.find(@params[:transaction_id])
  end

  def update_transaction_data
    @_transaction.update(amount: @args.amount)
  end
end
