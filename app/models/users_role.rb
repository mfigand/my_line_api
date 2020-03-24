class UsersRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates_uniqueness_of :user_id, :scope => [:user_id, :role_id]
end
