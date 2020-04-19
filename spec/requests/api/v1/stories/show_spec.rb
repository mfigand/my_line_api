# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'show story requests' do
  describe 'GET /api/v1/users/:user_id/stories/:id' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{user_id}/stories/#{story_id}",
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
    let(:story_id) { story.id }
    let(:user_id) { teller.id }
    let(:auth_token) { JsonWebToken.encode(user_id: teller.id) }
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid show with teller' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => story.title,
                                         'date' => story.date.strftime('%F'),
                                         'protagonist_id' => story.protagonist_id,
                                         'teller_id' => story.teller_id,
                                         'teller_title' => story.teller_title,
                                         'timeline_id' => story.timeline_id,
                                         'tags' => story.tags,
                                         'description' => story.description)
      end
    end

    context 'valid show with protagonist' do
      let(:user_id) { timeline.protagonist_id }
      let(:auth_token) { JsonWebToken.encode(user_id: timeline.protagonist_id) }

      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => story.title,
                                         'date' => story.date.strftime('%F'),
                                         'protagonist_id' => story.protagonist_id,
                                         'teller_id' => story.teller_id,
                                         'teller_title' => story.teller_title,
                                         'timeline_id' => story.timeline_id,
                                         'tags' => story.tags,
                                         'description' => story.description)
      end
    end

    context 'valid show with auhtor' do
      let(:user_id) { timeline.author_id }
      let(:auth_token) { JsonWebToken.encode(user_id: timeline.author_id) }

      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => story.title,
                                         'date' => story.date.strftime('%F'),
                                         'protagonist_id' => story.protagonist_id,
                                         'teller_id' => story.teller_id,
                                         'teller_title' => story.teller_title,
                                         'timeline_id' => story.timeline_id,
                                         'tags' => story.tags,
                                         'description' => story.description)
      end
    end

    context 'with not allowed user' do
      let(:user_not_allowed_to_show) { create(:user) }
      let(:auth_token) { JsonWebToken.encode(user_id: user_not_allowed_to_show.id) }

      it do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'cant find story' do
      let(:story_id) { '0' }

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
