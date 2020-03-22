# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update user requests' do
  describe 'PATCH /api/v1/users/:id' do
    subject(:endpoint_call) do
      patch "/api/v1/users/#{id}",
            params: update_params,
            headers: { 'Authentication' => auth_token }
    end

    let(:user) { create(:user) }
    let(:id) { user.id }
    let(:name_to_update) { 'updated_name' }
    let(:update_params) do
      { id: id, name: name_to_update }
    end
    let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
    let(:user_not_allow_to_update) { create(:user) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid token and allow to update' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('name' => name_to_update,
                                         'lastname' => user.lastname,
                                         'email' => user.email)
      end
    end

    context 'valid token but not allow to update' do
      let(:id) { user_not_allow_to_update.id }

      it do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'cant find user_to_update' do
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
