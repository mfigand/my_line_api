# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'author index requests' do
  describe 'GET /api/v1/users/:user_id/timelines/author_index' do
    subject(:endpoint_call) do
      get "/api/v1/users/#{author.id}/timelines/author_index",
          headers: { 'Authentication' => auth_token }
    end

    let(:author) { create(:user) }
    let(:auth_token) { JsonWebToken.encode(user_id: author.id) }
    let(:created_timelines) do
      5.times do |index|
        author.created_timelines.create(title: "title_#{index}")
      end
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    before do
      created_timelines
      subject
    end

    context '#author_index' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response.count).to be(created_timelines)
        expect(data_response.pluck('author_id').uniq).to eq([author.id])
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
