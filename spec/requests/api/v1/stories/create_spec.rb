# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create story requests' do
  describe 'POST /api/v1/users/:user_id/stories' do
    subject(:endpoint_call) do
      post "/api/v1/users/#{teller.id}/stories",
           params: params,
           headers: { 'Authentication' => auth_token }
    end

    let(:author) { create(:user) }
    let(:protagonist) { create(:user) }
    let(:timeline) { author.created_timelines.create(title: 'Timeline', protagonist: protagonist) }
    let(:timeline_id) { timeline.id }
    let(:teller) do
      teller = create(:user)
      teller.roles.create(name: 'teller',
                          resource: 'Timeline',
                          resource_id: timeline_id)
      teller
    end
    let(:auth_token) { JsonWebToken.encode(user_id: teller.id) }
    let(:params) do
      { title: 'Funny story',
        date: Time.now.utc - 5.days,
        teller_title: 'Uncle',
        timeline_id: timeline_id,
        tags: %w[tag_1 tag_2],
        description: 'Story description' }
    end
    let(:data_response) { JSON.parse(response.body)['data'] }

    context '#create' do
      it do
        expect { subject }.to change { Story.count }.by(1)
        expect(response).to have_http_status(200)
        expect(data_response).to include('title' => params[:title],
                                         'date' => params[:date].strftime('%F'),
                                         'protagonist_id' => timeline.protagonist.id,
                                         'teller_id' => teller.id,
                                         'teller_title' => params[:teller_title],
                                         'timeline_id' => timeline.id,
                                         #  'tags' => params[:tags],
                                         'description' => params[:description])
      end
    end

    context 'user not allowed to create' do
      let(:user_not_allow_to_create) { create(:user) }

      let(:not_allowed_user_token) { JsonWebToken.encode(user_id: user_not_allow_to_create.id) }
      let(:auth_token) { not_allowed_user_token }

      it do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "can't find timeline" do
      let(:timeline_id) { '0' }

      it do
        expect { subject }.to change { Story.count }.by(0)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'invalid schema' do
      let(:params) {}

      it do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
        expect(data_response).to eq("The property '#/story' did not contain a required property of 'date'")
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
