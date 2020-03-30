# frozen_string_literal: true

# rubocop:disable all
class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.date :date, null: false, index: true
      t.integer :protagonist_id, index: true
      t.integer :author_id, null: false, index: true
      t.integer :author_title, index: true
      t.integer :timeline_id, null: false, index: true
      t.jsonb :tags
      t.string :description, index: true

      t.timestamps
    end

    add_index :stories, :tags, using: :gin
    add_index :stories, :created_at
    add_index :stories, :updated_at
  end
end
# rubocop:enable all
