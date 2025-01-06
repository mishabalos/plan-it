class Finance::Expense < ApplicationRecord
  self.table_name = "expenses"

  belongs_to :budget
  belongs_to :user
  has_many :expense_splits, dependent: :destroy
  has_many :split_users, through: :expense_splits, source: :user

  validates :name, :amount, :category, :date, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
