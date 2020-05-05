# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroy timeline requests' do
  describe 'DELETE /api/v1/timelines/:id' do
    subject(:endpoint_call) do
      delete "/api/v1/timelines/#{timeline.id}",
             headers: { 'Authentication' => auth_token }
    end

    let(:author) { create(:user) }
    let(:author_token) { JsonWebToken.encode(user_id: author.id) }
    let(:user_id) { author.id }
    let(:auth_token) { author_token }
    let(:protagonist) { create(:user) }
    let(:title) { 'timeline_title' }
    let(:timeline) do
      author.created_timelines.create(title: title,
                                      protagonist_id: protagonist.id)
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { timeline }

    context 'valid credentials with author' do
      it do
        expect { subject }.to change { Timeline.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'valid credentials with protagonist' do
      let(:protagonist_token) { JsonWebToken.encode(user_id: protagonist.id) }
      let(:auth_token) { protagonist_token }

      it do
        expect { subject }.to change { Timeline.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'user not allowed to destroy' do
      let(:user_not_allow_to_delete) { create(:user) }

      let(:not_allowed_user_token) { JsonWebToken.encode(user_id: user_not_allow_to_delete.id) }
      let(:auth_token) { not_allowed_user_token }

      it do
        subject
        expect(response).to have_http_status(:unauthorized)
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
