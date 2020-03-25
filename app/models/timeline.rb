# frozen_string_literal: true

class Timeline < ApplicationRecord
  has_many :stories
  # has_many :tellers, through: :timelines_tellers, source: :teller_id
  has_many :timelines_tellers, foreign_key: 'timeline_id'
  has_many :tellers, through: :timelines_tellers

  belongs_to :protagonist, class_name: 'User', foreign_key: 'protagonist_id', optional: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :author_id, presence: true
end
