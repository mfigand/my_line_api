# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'protagonist index requests' do
  describe 'GET /api/v1/users/:user_id/stories/protagonist_index' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{protagonist.id}/stories/protagonist_index",
          headers: { 'Authentication' => auth_token }
    end

    let(:protagonist) { create(:user) }
    let(:timeline) { create(:timeline, protagonist_id: protagonist.id) }
    let(:auth_token) { JsonWebToken.encode(user_id: protagonist.id) }
    let(:stories) do
      5.times do |index|
        protagonist.told_stories.create(date: Time.now.utc - index.days,
                                        timeline: timeline)
      end
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before do
      stories
      subject
    end

    context '#protagonist_index' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response.count).to be(stories)
        expect(data_response.pluck('protagonist_id').uniq).to eq([protagonist.id])
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
