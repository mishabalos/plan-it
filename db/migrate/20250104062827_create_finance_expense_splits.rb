class CreateFinanceExpenseSplits < ActiveRecord::Migration[7.2]
  def change
    create_table :expense_splits do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
