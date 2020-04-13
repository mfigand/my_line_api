# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'show timeline requests' do
  describe 'GET /api/v1/users/:user_id/timelines/:id' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{user_id}/timelines/#{timeline.id}",
          headers: { 'Authentication' => auth_token }
    end

    let(:author) { create(:user) }
    let(:protagonist) { create(:user) }
    let(:title) { 'timeline_title' }
    let(:timeline) do
      create(:timeline, title: title,
                        author: author,
                        protagonist: protagonist)
    end
    let(:user_id) { author.id }
    let(:auth_token) { JsonWebToken.encode(user_id: author.id) }
    let(:teller) do
      teller = create(:user)
      teller.roles.create(name: 'teller',
                          resource: 'Timeline',
                          resource_id: timeline.id)
      teller
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid show with author' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => title,
                                         'author_id' => author.id,
                                         'protagonist_id' => protagonist.id)
      end
    end

    context 'valid show with protagonist' do
      let(:user_id) { protagonist.id }
      let(:auth_token) { JsonWebToken.encode(user_id: protagonist.id) }

      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => title,
                                         'author_id' => author.id,
                                         'protagonist_id' => protagonist.id)
      end
    end

    context 'valid show with teller' do
      let(:user_id) { teller.id }
      let(:auth_token) { JsonWebToken.encode(user_id: teller.id) }

      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => title,
                                         'author_id' => author.id,
                                         'protagonist_id' => protagonist.id)
      end
    end

    context 'with not allowed user' do
      let(:user_not_allowed_to_show) { create(:user) }
      let(:auth_token) { JsonWebToken.encode(user_id: user_not_allowed_to_show.id) }

      it do
        expect(response).to have_http_status(:unauthorized)
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
