# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  let(:user) { create(:user) }
  let(:params) do
    { email: user.email, password: user.password }
  end

  describe '#authenticate' do
    it do
      post :authenticate, params: params
      expect(response.status).to eq(200)
    end
  end
end
