# frozen_string_literal: true

class Role < ApplicationRecord
  enum name: { superadmin: 1, admin: 2, teller: 3 }
  enum resource: { Timeline: 1 }

  has_many :users_roles, dependent: :destroy
  has_many :users, through: :users_roles

  validates :name, presence: true
end
