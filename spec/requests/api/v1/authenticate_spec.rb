# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'authenticate requests' do
  describe 'POST /authenticate' do
    subject(:endpoint_call) { post '/api/v1/authenticate', params: params }

    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:params) do
      { email: email, password: user.password }
    end
    let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    context 'valid credentials' do
      it do
        subject
        expect(data_response).to eq(auth_token)
      end
    end

    context 'invalid credentials' do
      let(:email) { 'invalid@email.com' }

      it do
        subject
        expect(data_response).to eq("Invalid credentials - Couldn't find User")
      end
    end
  end
end
