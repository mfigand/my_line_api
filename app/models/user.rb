# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  default_scope -> { where(deleted_at: nil) }

  has_many :users_roles, dependent: :destroy
  has_many :roles, through: :users_roles
  has_many :timelines, class_name: 'Timeline',
                       foreign_key: 'protagonist_id',
                       inverse_of: :protagonist,
                       dependent: :nullify
  has_many :timelines, class_name: 'Timeline',
                               foreign_key: 'author_id',
                               inverse_of: :author
  has_many :stories, class_name: 'Story',
                     foreign_key: 'protagonist_id',
                     inverse_of: :protagonist,
                     dependent: :nullify
  has_many :told_stories, class_name: 'Story',
                          foreign_key: 'author_id',
                          inverse_of: :author
  has_many :timelines_tellers, foreign_key: 'teller_id',
                               inverse_of: :teller,
                               dependent: :destroy
  has_many :collaborative_lines, through: :timelines_tellers,
                                 source: :timeline

  validates :name, :lastname, length: { maximum: 250 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true,
                       format: { with: /\A[a-zA-ZÑñ0-9\ ]+\z/ },
                       length: { minimum: 8 },
                       if: :password
  # validates_each :password do |record, attr, value|
  #   record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  #   end
  # /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{8,}$/

  def soft_delete
    update(deleted_at: Time.now.utc)
  end
end
