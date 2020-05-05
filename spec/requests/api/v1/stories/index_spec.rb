# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'index requests' do
  describe 'GET /api/v1/timelines/:timeline_id/stories' do
    subject(:endpoint_call) do
      get "/api/v1/timelines/#{timeline.id}/stories",
          headers: { 'Authentication' => auth_token }
    end

    let(:user) { create(:user) }
    let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
    let(:timeline) { user.created_timelines.create(title: 'Timeline') }
    let(:told_stories) do
      5.times do |index|
        user.told_stories.create(date: Time.now.utc - index.days, timeline: timeline)
      end
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before do
      told_stories
      subject
    end

    context '#index' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response.count).to be(told_stories)
        expect(data_response.pluck('timeline_id').uniq).to eq([timeline.id])
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
