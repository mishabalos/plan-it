class Finance::ExpenseSplit < ApplicationRecord
  self.table_name = "expense_splits"

  belongs_to :expense
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
