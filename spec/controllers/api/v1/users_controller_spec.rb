# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:create_params) do
    { email: generate(:email), password: '12345678' }
  end
  let(:user) { create(:user) }
  let(:id) { user.id }
  let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
  let(:valid_headers) do
    { 'Authentication' => auth_token }
  end
  let(:new_name) { 'New name' }
  let(:update_params) do
    { id: id, name: new_name }
  end

  before do
    request.headers.merge!(valid_headers)
  end

  describe '#create' do
    it do
      post :create, params: create_params
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    it do
      get :show, params: { id: id }
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    it do
      patch :update, params: update_params
      expect(response.status).to eq(200)
    end
  end

  describe '#destroy' do
    it do
      delete :destroy, params: { id: id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
