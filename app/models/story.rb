# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :timeline

  belongs_to :protagonist, class_name: 'User',
                           foreign_key: 'protagonist_id',
                           optional: true,
                           inverse_of: :stories
  belongs_to :author, class_name: 'User',
                      foreign_key: 'author_id',
                      inverse_of: :told_stories

  validates :author_id, presence: true
end
