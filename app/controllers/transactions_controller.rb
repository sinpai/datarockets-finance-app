class TransactionsController < ApplicationController
  before_action :authenticate_user!

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

  private

  def transaction_params
    params.require(:transaction).permit(:sum, :date, :comment)
  end
end
