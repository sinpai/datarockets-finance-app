class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
    @transaction = Transaction.new
    @recent_records = current_user.transactions.most_recent
  end
end
