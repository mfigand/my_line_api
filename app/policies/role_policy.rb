# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def create?
    default_policies
  end

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
    # only permit author or protagonist timeline
    record.author == user || record.protagonist == user
  end
end
