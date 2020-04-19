# frozen_string_literal: true

class Timeline < ApplicationRecord
  has_many :stories, dependent: :restrict_with_exception
  has_many :timelines_tellers, foreign_key: 'timeline_id',
                               inverse_of: :timeline,
                               dependent: :destroy
  has_many :tellers, through: :timelines_tellers

  belongs_to :protagonist, class_name: 'User',
                           foreign_key: 'protagonist_id',
                           optional: true,
                           inverse_of: :timelines
  belongs_to :author, class_name: 'User',
                      foreign_key: 'author_id',
                      inverse_of: :created_timelines

  validates :author_id, presence: true
end
