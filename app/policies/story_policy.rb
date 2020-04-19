# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  def create?
    teller
  end

  def show?
    default_policies || teller
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
    record.teller == user || record.protagonist == user
  end

  def teller
    user.roles.find_by(name: 'teller', resource: record.class.name, resource_id: record.id).present?
  end
end
