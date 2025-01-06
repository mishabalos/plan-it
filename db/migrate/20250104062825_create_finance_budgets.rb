class CreateFinanceBudgets < ActiveRecord::Migration[7.2]
  def change
    create_table :budgets do |t|
      t.references :trip, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
