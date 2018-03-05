class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
    @transaction = Transaction.new
    @recent_records = Transaction.most_recent(current_user)
  end
end
