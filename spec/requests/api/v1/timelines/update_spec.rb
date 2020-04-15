# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update timeline requests' do
  describe 'PATCH /api/v1/users/:user_id/timelines/:id' do
    subject(:endpoint_call) do
      patch "/api/v1/users/#{user_id}/timelines/#{timeline.id}",
            params: params,
            headers: { 'Authentication' => auth_token }
    end

    let(:author) { create(:user) }
    let(:old_protagonist) { create(:user) }
    let(:timeline) do
      create(:timeline, title: 'old_title',
                        author: author,
                        protagonist: old_protagonist)
    end
    let(:new_title) { 'new_title' }
    let(:new_protagonist) { create(:user) }
    let(:params) do
      { title: new_title,
        author_id: 'other_author_id',
        protagonist_id: new_protagonist.id }
    end
    let(:auth_token) { JsonWebToken.encode(user_id: author.id) }
    let(:user_id) { author.id }
    let(:data_response) { JSON.parse(response.body)['data'] }

    before { subject }

    context 'valid update with author' do
      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => new_title,
                                         'author_id' => author.id,
                                         'protagonist_id' => new_protagonist.id)
      end
    end

    context 'valid update with protagonist' do
      let(:user_id) { old_protagonist.id }
      let(:auth_token) { JsonWebToken.encode(user_id: old_protagonist.id) }

      it do
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => new_title,
                                         'author_id' => author.id,
                                         'protagonist_id' => old_protagonist.id)
      end
    end

    context 'invalid update with teller' do
      let(:teller) do
        teller = create(:user)
        teller.roles.create(name: 'teller',
                            resource: 'Timeline',
                            resource_id: timeline.id)
        teller
      end
      let(:user_id) { teller.id }
      let(:auth_token) { JsonWebToken.encode(user_id: teller.id) }

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
