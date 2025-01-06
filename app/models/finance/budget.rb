class Finance::Budget < ApplicationRecord
  self.table_name = "budgets"

  belongs_to :trip
  has_many :expenses, dependent: :destroy
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def remaining_amount
    amount - expenses.sum(:amount)
  end
end
