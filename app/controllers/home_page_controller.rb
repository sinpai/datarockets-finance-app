class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
    @balance_transaction = BalanceTransaction.new
    @balance_transaction.transactions.build
    @recent_records = current_user.transactions.most_recent
  end
end
