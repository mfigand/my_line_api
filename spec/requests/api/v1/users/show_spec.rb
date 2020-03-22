# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'show user requests' do
  describe 'GET /api/v1/users/:id' do
    subject(:endpoint_call) { get "/api/v1/users/#{id}", headers: { 'Authentication' => auth_token } }

    let(:user) { create(:user) }
    let(:id) { user.id }
    let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
    let(:user_not_allow_to_show) { create(:user) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid token and allow to show' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('name' => user.name,
                                         'lastname' => user.lastname,
                                         'email' => user.email)
      end
    end

    context 'valid token but not allow to show' do
      let(:id) { user_not_allow_to_show.id }

      it do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'cant find user_to_show' do
      let(:id) { '0' }

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
