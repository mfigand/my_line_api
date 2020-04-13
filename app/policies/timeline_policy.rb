# frozen_string_literal: true

class TimelinePolicy < ApplicationPolicy
  def show?
    default_policies
  end

  def update?
    default_policies
  end

  def destroy?
    # only permit author or protagonist record
    default_policies
  end

  private

  def default_policies
    record.author == user || record.protagonist == user
  end
end
