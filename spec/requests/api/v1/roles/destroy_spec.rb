# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroy role requests' do
  describe 'DELETE /api/v1/users/:user_id/roles/:id' do
    subject(:endpoint_call) do
      delete "/api/v1/users/#{user_id}/roles/#{role_id}",
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

    before { role }

    context 'valid destroy with author timeline' do
      it do
        expect { subject }.to change { Role.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'valid destroy with protagonist timeline' do
      let(:user_id) { timeline.protagonist_id }
      let(:auth_token) { JsonWebToken.encode(user_id: user_id) }

      it do
        expect { subject }.to change { Role.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'invalid destroy with not allowed user' do
      let(:user_not_allowed_to_destroy) { create(:user) }
      let(:auth_token) { JsonWebToken.encode(user_id: user_not_allowed_to_destroy.id) }

      it do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'invalid token' do
      let(:auth_token) { '' }

      it do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
