# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroy story requests' do
  describe 'DELETE /api/v1/users/:user_id/stories/:id' do
    subject(:endpoint_call) do
      delete "/api/v1/users/#{user_id}/stories/#{story.id}",
             headers: { 'Authentication' => auth_token }
    end

    let(:timeline) { create(:timeline) }
    let(:teller) do
      teller = create(:user)
      teller.roles.create(name: 'teller',
                          resource: 'Timeline',
                          resource_id: timeline.id)
      teller
    end
    let(:story) { create(:story, teller_id: teller.id, timeline_id: timeline.id) }
    let(:user_id) { teller.id }
    let(:auth_token) { JsonWebToken.encode(user_id: teller.id) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { story }

    context 'valid destroy with teller' do
      it do
        expect { subject }.to change { Story.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'valid destroy with protagonist' do
      let(:user_id) { timeline.protagonist_id }
      let(:auth_token) { JsonWebToken.encode(user_id: timeline.protagonist_id) }

      it do
        expect { subject }.to change { Story.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'invalid destroy with auhtor' do
      let(:user_id) { timeline.author_id }
      let(:auth_token) { JsonWebToken.encode(user_id: timeline.author_id) }

      it do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'invalid destroy with not allowed user' do
      let(:user_not_allowed_to_destroy) { create(:user) }
      let(:auth_token) { JsonWebToken.encode(user_id: user_not_allowed_to_destroy.id) }

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
