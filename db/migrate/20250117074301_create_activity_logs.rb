class CreateActivityLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :activity_logs do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.string :target_type
      t.integer :target_id
      t.jsonb :details

      t.timestamps
    end
  end
end
