class CreateTimelinesTellers < ActiveRecord::Migration[6.0]
  def change
    create_table :timelines_tellers do |t|
      t.integer :timeline_id, null: false, index: true
      t.integer :teller_id, null: false, index: true

      t.timestamps
    end

    add_index :timelines_tellers, [:timeline_id, :teller_id], :unique => true
    add_index :timelines_tellers, :created_at
    add_index :timelines_tellers, :updated_at
  end
end
