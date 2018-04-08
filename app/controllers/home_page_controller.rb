class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
    @form = BalanceTransactionForm.new(BalanceTransaction.new, transactions: Transaction.new)
    @recent_records = current_user.transactions.most_recent.decorate
  end
end
