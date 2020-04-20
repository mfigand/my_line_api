# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create stories' do
  subject { V1::Stories::CreateInteractor.new(teller, create_params).create }

  let(:timeline) { create(:timeline) }
  let(:teller) do
    teller = create(:user)
    teller.roles.create(name: 'teller',
                        resource: 'Timeline',
                        resource_id: timeline.id)
    teller
  end
  let(:create_params) do
    { timeline_id: timeline.id,
      date: nil }
  end

  describe 'fail by validation' do
    it do
      expect(subject[:status]).to eq(:unprocessable_entity)
      expect(subject[:data]).to eq("Error: Validation failed: Date can't be blank")
    end
  end
end
