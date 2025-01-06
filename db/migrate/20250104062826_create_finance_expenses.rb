class CreateFinanceExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.references :budget, null: false, foreign_key: true
      t.string :name
      t.decimal :amount
      t.string :category
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
