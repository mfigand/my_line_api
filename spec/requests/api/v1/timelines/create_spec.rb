# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create timelines requests' do
  describe 'POST /api/v1/users/:user_id/timelines' do
    subject(:endpoint_call) do
      post "/api/v1/users/#{author.id}/timelines",
           params: params,
           headers: { 'Authentication' => auth_token }
    end

    let(:author) { create(:user) }
    let(:auth_token) { JsonWebToken.encode(user_id: author.id) }
    let(:protagonist) { create(:user) }
    let(:title) { 'timeline_title' }
    let(:params) do
      { author_id: author.id,
        protagonist_id: protagonist.id,
        title: title }
    end
    let(:user_not_allow_to_create) { create(:user) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid credentials' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('author_id' => author.id,
                                         'protagonist_id' => protagonist.id,
                                         'title' => title)
      end
    end

    context 'invalid schema' do
      let(:params) {}

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(data_response).to eq("The property '#/timeline' did not contain a required property of 'author_id'")
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
