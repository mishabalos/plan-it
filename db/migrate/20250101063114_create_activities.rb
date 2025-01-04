class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
