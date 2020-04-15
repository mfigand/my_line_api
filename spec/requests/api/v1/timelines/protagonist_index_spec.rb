# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'protagonist index requests' do
  describe 'GET /api/v1/users/:user_id/timelines/protagonist_index' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{protagonist.id}/timelines/protagonist_index",
          headers: { 'Authentication' => auth_token }
    end

    let(:protagonist) { create(:user) }
    let(:auth_token) { JsonWebToken.encode(user_id: protagonist.id) }
    let(:protagonist_timelines) do
      5.times do |index|
        protagonist.created_timelines.create(title: "title_#{index}",
                                             protagonist_id: protagonist.id)
      end
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before do
      protagonist_timelines
      subject
    end

    context '#protagonist_index' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response.count).to be(protagonist_timelines)
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
