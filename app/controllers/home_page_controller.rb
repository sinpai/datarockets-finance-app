class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
    @transaction = Transaction.new
  end
end
