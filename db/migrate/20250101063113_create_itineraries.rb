class CreateItineraries < ActiveRecord::Migration[7.2]
  def change
    create_table :itineraries do |t|
      t.date :date
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
