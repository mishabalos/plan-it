class AddLocationToTrips < ActiveRecord::Migration[7.2]
  def change
    add_column :trips, :latitude, :decimal, precision: 10, scale: 6
    add_column :trips, :longitude, :decimal, precision: 10, scale: 6
    add_column :trips, :location_name, :string
  end
end
