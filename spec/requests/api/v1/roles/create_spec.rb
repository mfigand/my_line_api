# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create role requests' do
  describe 'POST /api/v1/users/:user_id/roles' do
    subject(:endpoint_call) do
      post "/api/v1/users/#{user.id}/roles",
           params: params,
           headers: { 'Authentication' => auth_token }
    end

    # let(:superadmin) do
    #   superadmin = create(:user)
    #   superadmin.roles.create(name: 'superadmin')
    #   superadmin
    # end
    let(:user) { create(:user) }
    let(:protagonist) { create(:user) }
    let(:timeline) { user.created_timelines.create(title: 'Timeline', protagonist: protagonist) }
    let(:resource_id) { timeline.id }
    let(:params) do
      { name: 'teller',
        resource: 'Timeline',
        resource_id: resource_id }
    end
    let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    context '#create' do
      it do
        expect { subject }.to change { Role.count }.by(1)
        expect(response).to have_http_status(200)
        expect(data_response).to include('name' => params[:name],
                                         'resource' => params[:resource],
                                         'resource_id' => params[:resource_id])
      end
    end

    context 'user not allowed to create' do
      let(:user_not_allow_to_create) { create(:user) }

      let(:not_allowed_user_token) { JsonWebToken.encode(user_id: user_not_allow_to_create.id) }
      let(:auth_token) { not_allowed_user_token }

      it do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "can't find timeline" do
      let(:resource_id) { '0' }

      it do
        expect { subject }.to change { Role.count }.by(0)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'invalid schema' do
      let(:params) {}

      it do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
        expect(data_response).to eq("The property '#/role' did not contain a required property of 'name'")
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
