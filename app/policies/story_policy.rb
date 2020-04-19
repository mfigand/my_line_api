# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  def create?
    teller_role || record.protagonist == user || record.author == user
  end

  def show?
    default_policies || record.timeline.author == user
  end

  def update?
    default_policies
  end

  def destroy?
    default_policies
  end

  private

  def default_policies
    # only permit teller or protagonist timeline
    record.teller == user || record.timeline.protagonist == user
  end

  def teller_role
    user.roles.find_by(name: 'teller', resource: record.class.name, resource_id: record.id).present?
  end
end
