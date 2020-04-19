# frozen_string_literal: true

class Story < ApplicationRecord
  enum teller_title: { Dad: 0, Mom: 1, Bro: 2, Sis: 3, Grandpa: 4, Grandma: 5,
                       Uncle: 6, Cousin: 7, Nephew: 8, Grandchild: 9, Friend: 10 }

  belongs_to :timeline

  belongs_to :protagonist, class_name: 'User',
                           foreign_key: 'protagonist_id',
                           optional: true,
                           inverse_of: :stories
  belongs_to :teller, class_name: 'User',
                      foreign_key: 'teller_id',
                      inverse_of: :told_stories

  validates :teller_id, :date, :timeline_id, presence: true

  before_validation do
    self.protagonist_id = timeline.protagonist_id if timeline
  end
end
