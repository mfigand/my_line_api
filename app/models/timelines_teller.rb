# frozen_string_literal: true

class TimelinesTeller < ApplicationRecord
  # belongs_to :user
  belongs_to :teller, class_name: 'User', foreign_key: 'teller_id'
  belongs_to :timeline

  validates :timeline_id, uniqueness: { scope: %i[timeline_id teller_id] }
end
