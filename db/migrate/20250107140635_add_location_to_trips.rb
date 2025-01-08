class AddLocationToTrips < ActiveRecord::Migration[7.2]
  def change
    add_column :trips, :location, :string
  end
end
