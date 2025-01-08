class AddLocationToActivities < ActiveRecord::Migration[7.2]
  def change
    add_column :activities, :latitude, :decimal, precision: 10, scale: 6
    add_column :activities, :longitude, :decimal, precision: 10, scale: 6
    add_column :activities, :location_name, :string
    add_column :activities, :formatted_address, :string
  end
end
