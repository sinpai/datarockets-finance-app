class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
    @form = BalanceTransactionForm.new(BalanceTransaction.new, transactions: Transaction.new)
    @recent_records = current_user.transactions.includes(:transactinable).most_recent.decorate
    @categories = current_user.categories.top_category.decorate
  end
end
