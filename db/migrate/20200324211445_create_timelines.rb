# frozen_string_literal: true

class CreateTimelines < ActiveRecord::Migration[6.0]
  def change
    create_table :timelines do |t|
      t.string :title, index: true
      t.integer :protagonist_id, index: true
      t.integer :author_id, null: false, index: true

      t.timestamps
    end

    add_index :timelines, :created_at
    add_index :timelines, :updated_at
  end
end
