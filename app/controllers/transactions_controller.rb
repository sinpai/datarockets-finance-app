class TransactionsController < ApplicationController
  def new
    @transaction = current_user.transactions.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    if @transaction.save
      redirect_to root_path, notice: t('.success')
    else
      render 'new', notice: t('.failure')
    end
  end

  def recent_records
    @recent_records = Transaction.most_recent
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sum, :date, :comment)
  end
end
