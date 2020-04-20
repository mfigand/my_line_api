# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update stories' do
  subject { V1::Stories::UpdateInteractor.new(teller, update_params).update }

  let(:teller) { create(:user) }
  let(:story) { create(:story, teller: teller) }
  let(:update_params) do
    { date: '',
      id: story.id }
  end

  describe 'fail by validation' do
    it do
      expect(subject[:status]).to eq(:unprocessable_entity)
      expect(subject[:data]).to eq("Error: Validation failed: Date can't be blank")
    end
  end
end
