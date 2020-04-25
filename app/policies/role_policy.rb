# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def create?
    default_policies
  end

  def show?
    default_policies
  end

  def destroy?
    default_policies
  end

  private

  def default_policies
    # only permit author or protagonist timeline
    author == user || protagonist == user
  end

  def timeline
    @timeline ||= ::V1::Timelines::FindRepository.new(record.resource_id).find
  end

  def author
    record.instance_of?(Timeline) ? record.author : timeline.author
  end

  def protagonist
    record.instance_of?(Timeline) ? record.protagonist : timeline.protagonist
  end
end
