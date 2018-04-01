class CrossCategoriesTransactions::Creator
  def initialize(amount:, user_id:, category_from_id:, category_to_id:)
    @amount = amount
    @user_id = user_id
    @category_from_id = category_from_id
    @category_to_id = category_to_id
  end

  def call
    return unless valid?
    ActiveRecord::Base.transaction do
      create_cross_category_transaction
      create_transaction
      transfer_money_between_categories
    end
  end

  private

  def create_cross_category_transaction
    @transaction = CrossCategoriesTransaction.create(
      category_from_id: @category_from_id,
      category_to_id: @category_to_id
    )
  end

  def create_transaction
    @transaction.transactions.create(
      amount: @amount,
      user_id: @user_id
    )
  end

  def transfer_money_between_categories
    category_from.update(amount: category_from_amount)
    category_to.update(amount: category_to_amount)
  end

  def category_from_amount
    @category_from.amount - @amount
  end

  def category_to_amount
    @category_to.amount + @amount
  end

  def valid?
    category_from.amount >= @amount
  end

  def category_from
    @category_from ||= categories.find(@category_from_id)
  end

  def category_to
    @category_to ||= categories.find(@category_to_id)
  end

  def user
    @_user ||= User.find(@user_id)
  end

  delegate :categories, to: :user
end
