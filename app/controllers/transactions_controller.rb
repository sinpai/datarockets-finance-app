class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[update destroy edit]
  before_action :set_new_transaction, only: %i[new index]
  before_action :perform_search, only: %i[index search]

  def index
  end

  def search
    render :index
  end

  def new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    if @transaction.save
      redirect_to transactions_path, notice: t('.success')
    else
      render 'new', notice: t('.failure')
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to root_path
    else
      render 'edit'
    end

    respond_to do |format|
      format.html { redirect_to transactions_path }
      format.js { render layout: false }
    end
  end

  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_path }
      format.js { render layout: false }
    end
  end

  private

  def perform_search
    @search = current_user.transactions.ransack(params[:q])
    @transactions = @search.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_new_transaction
    @transaction = current_user.transactions.new
  end

  def transaction_params
    params.require(:transaction).permit(:id, :sum, :date, :comment)
  end
end
