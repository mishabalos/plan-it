class CreateTripCollaborators < ActiveRecord::Migration[7.2]
  def change
    create_table :trip_collaborators do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
