class BalanceTransactionForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods

  model :balance_transaction

  validates :comment, length: {maximum: 80}
  property :id
  property :comment
  property :date

  property :transactions do
    property :amount

    validates :amount, presence: true
    validates :amount, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                       numericality: {greater_than_or_equal_to: 0, less_than: 1_000_000_00}
  end
end
