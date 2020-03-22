# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'delete user requests' do
  describe 'DELETE /api/v1/users/:id' do
    subject(:endpoint_call) { delete "/api/v1/users/#{id}", headers: { 'Authentication' => auth_token } }

    let(:current_user) { create(:user) }
    let(:id) { current_user.id }
    let(:auth_token) { JsonWebToken.encode(user_id: current_user.id) }
    let(:user_not_allow_to_delete) { create(:user) }

    before do
      user_not_allow_to_delete
      current_user
    end

    context 'valid token and allow to delete' do
      it do
        expect { subject }.to change { User.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'valid token but not allow to delete' do
      let(:id) { user_not_allow_to_delete.id }

      it do
        expect { subject }.to change { User.count }.by(0)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'cant find user_to_delete' do
      let(:id) { '0' }

      it do
        expect { subject }.to change { User.count }.by(0)
        expect(response).to have_http_status(:not_found)
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
