# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'roles routing' do
  let(:controller) { 'api/v1/roles' }
  let(:user) { create(:user) }
  let(:timeline) { create(:timeline) }
  let(:role) do
    user.roles.create(name: 'teller',
                      resource: 'Timeline',
                      resource_id: timeline.id)
  end

  it '#index' do
    expect(get: api_v1_user_roles_path(user))
      .to route_to(controller: controller,
                   action: 'index',
                   user_id: user.id.to_s)
  end

  it '#create' do
    expect(post: api_v1_user_roles_path(user))
      .to route_to(controller: controller,
                   action: 'create',
                   user_id: user.id.to_s)
  end

  it '#show' do
    expect(get: api_v1_user_role_path(user, role))
      .to route_to(controller: controller,
                   action: 'show',
                   user_id: user.id.to_s,
                   id: role.id.to_s)
  end

  it '#update' do
    expect(patch: api_v1_user_role_path(user, role))
      .to route_to(controller: controller,
                   action: 'update',
                   user_id: user.id.to_s,
                   id: role.id.to_s)
  end

  it 'destroy' do
    expect(delete: api_v1_user_role_path(user, role))
      .to route_to(controller: controller,
                   action: 'destroy',
                   user_id: user.id.to_s,
                   id: role.id.to_s)
  end
end
