# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    default_policies
  end

  def update?
    default_policies
  end

  def destroy?
    default_policies
  end

  private

  def default_policies
    # only permit operate under its own record
    user == record
  end
end
