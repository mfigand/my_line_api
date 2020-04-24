# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'roles index requests' do
  describe 'GET /api/v1/users/:user_id/roles' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{user.id}/roles",
          headers: { 'Authentication' => auth_token }
    end

    let(:user) { create(:user) }
    let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
    let(:timeline_1) { create(:timeline) }
    let(:timeline_2) { create(:timeline) }
    let(:roles) do
      [timeline_1, timeline_2].map do |t|
        user.roles.create(name: 'teller',
                          resource: 'Timeline',
                          resource_id: t.id)
      end
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before do
      roles
      subject
    end

    context '#index' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response.count).to be(roles.count)
        expect(data_response.pluck('resource_id')).to eq(roles.pluck(:resource_id))
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
