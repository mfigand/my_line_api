# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users routing' do
  let(:controller) { 'api/v1/users' }
  let(:user) { create(:user) }

  it do
    expect(get: api_v1_users_path).to route_to(controller: controller,
                                               action: 'index')
  end

  it do
    expect(post: api_v1_users_path).to route_to(controller: controller,
                                                action: 'create')
  end

  it do
    expect(get: api_v1_user_path(user)).to route_to(controller: controller,
                                                    action: 'show',
                                                    id: user.id.to_s)
  end

  it do
    expect(patch: api_v1_user_path(user)).to route_to(controller: controller,
                                                      action: 'update',
                                                      id: user.id.to_s)
  end

  it do
    expect(delete: api_v1_user_path(user)).to route_to(controller: controller,
                                                       action: 'destroy',
                                                       id: user.id.to_s)
  end
end
