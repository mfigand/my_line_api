# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'show role requests' do
  describe 'GET /api/v1/users/:user_id/roles/:id' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{user_id}/roles/#{role_id}",
          headers: { 'Authentication' => auth_token }
    end

    let(:user) { create(:user) }
    let(:user_id) { user.id }
    let(:protagonist) { create(:user) }
    let(:timeline) { user.created_timelines.create(title: 'Timeline', protagonist: protagonist) }
    let(:role) { user.roles.create(name: 'teller', resource: 'Timeline', resource_id: timeline.id) }
    let(:role_id) { role.id }
    let(:auth_token) { JsonWebToken.encode(user_id: user_id) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid show with author' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('name' => role.name,
                                         'resource' => role.resource,
                                         'resource_id' => role.resource_id)
      end
    end

    context 'valid show with protagonist' do
      let(:user_id) { timeline.protagonist_id }
      let(:auth_token) { JsonWebToken.encode(user_id: user_id) }

      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('name' => role.name,
                                         'resource' => role.resource,
                                         'resource_id' => role.resource_id)
      end
    end

    context 'with not allowed user' do
      let(:user_not_allowed_to_show) { create(:user) }
      let(:auth_token) { JsonWebToken.encode(user_id: user_not_allowed_to_show.id) }

      it do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'cant find role' do
      let(:role_id) { '0' }

      it do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'invalid token' do
      let(:auth_token) { '' }

      it do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
