# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :timeline

  belongs_to :protagonist, class_name: 'User', foreign_key: 'protagonist_id', optional: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :author_id, presence: true
end
