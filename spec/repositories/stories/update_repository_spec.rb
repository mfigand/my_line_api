# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update stories' do
  subject { V1::Stories::UpdateRepository.new(update_params).update }

  let(:story) { create(:story) }
  let(:update_params) do
    { story: story,
      date: nil,
      teller_id: nil }
  end

  describe 'fail by validation' do
    it do
      expect(subject[:error]).to eq("Validation failed: Date can't be blank")
    end
  end
end
