class CreateDestinations < ActiveRecord::Migration[7.2]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :country
      t.string :city
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
