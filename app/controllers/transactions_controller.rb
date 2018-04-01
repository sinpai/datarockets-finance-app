class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :perform_search, only: %i[index search]

  def index
  end

  def search
    render :index
  end

  private

  def perform_search
    @search = current_user.transactions.includes(:transactinable).ransack(params[:q])
    @transactions = @search.result(distinct: true).paginate(page: params[:page], per_page: 10).decorate
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :date)
  end
end
