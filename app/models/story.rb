# frozen_string_literal: true

class Story < ApplicationRecord
  enum teller_title: { Dad: 1, Mom: 2, Bro: 3, Sis: 4, Grandpa: 5, Grandma: 6,
                       Uncle: 7, Cousin: 8, Nephew: 9, Grandchild: 10, Friend: 11 }

  has_one_attached :photo

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

  def photo_url
    ENV['LOCALHOST'] + Rails.application.routes.url_helpers.rails_blob_path(photo, only_path: true) if photo.attached?
  end
end
