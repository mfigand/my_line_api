# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create user requests' do
  describe 'POST /api/v1/users' do
    subject(:endpoint_call) { post '/api/v1/users', params: params }

    let(:name) { 'Manuel' }
    let(:lastname) { 'Figueroa' }
    let(:email) { generate(:email) }
    let(:password) { '12345678' }
    let(:params) do
      { name: name, lastname: lastname, email: email, password: password }
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid credentials' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('email' => email)
      end
    end

    context 'invalid credentials' do
      let(:email) { '' }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(data_response).to eq("Error: Validation failed: Email can't be blank")
      end
    end

    context 'invalid schema' do
      let(:params) {}

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(data_response).to eq("The property '#/user' did not contain a required property of 'email'")
      end
    end
  end
end
