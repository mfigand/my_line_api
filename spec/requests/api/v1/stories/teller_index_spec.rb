# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teller index requests' do
  describe 'GET /api/v1/users/:user_id/stories/teller_index' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{teller.id}/stories/teller_index",
          headers: { 'Authentication' => auth_token }
    end

    let(:teller) { create(:user) }
    let(:auth_token) { JsonWebToken.encode(user_id: teller.id) }
    let(:timeline) { teller.created_timelines.create(title: 'Timeline') }
    let(:told_stories) do
      5.times do |index|
        teller.told_stories.create(date: Time.now.utc - index.days, timeline: timeline)
      end
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before do
      told_stories
      subject
    end

    context '#teller_index' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response.count).to be(told_stories)
        expect(data_response.pluck('teller_id').uniq).to eq([teller.id])
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
