# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create roles' do
  subject { V1::Roles::CreateInteractor.new(user, create_params).create }

  let(:user) { create(:user) }
  let(:protagonist) { create(:user) }
  let(:timeline) { user.created_timelines.create(title: 'Timeline', protagonist: protagonist) }
  let(:resource_id) { timeline.id }
  let(:role_name) { 'Admin' }
  let(:create_params) do
    { name: role_name,
      resource: 'Timeline',
      resource_id: resource_id }
  end
  let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
  let(:data_response) { JSON.parse(response.body)['data'] }

  describe 'fail by validation' do
    it do
      expect(subject[:status]).to eq(:unprocessable_entity)
      expect(subject[:data]).to eq("Error: '#{role_name}' is not a valid name")
    end
  end
end
