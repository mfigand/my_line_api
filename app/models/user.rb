# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :users_roles
  has_many :roles, through: :users_roles
  has_many :timelines, class_name: "Timeline", foreign_key: "protagonist_id"
  has_many :created_timelines, class_name: "Timeline", foreign_key: "author_id"
  has_many :stories, class_name: "Story", foreign_key: "protagonist_id"
  has_many :told_stories, class_name: "Story", foreign_key: "author_id"

  validates :name, :lastname, length: { maximum: 250 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true,
                       format: { with: /\A[a-zA-ZÑñ0-9\ ]+\z/ },
                       if: :password
  # validates :password, length: { minumum: 8 }
  # validates_each :password do |record, attr, value|
  #   record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  #   end
  # /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{8,}$/
end
