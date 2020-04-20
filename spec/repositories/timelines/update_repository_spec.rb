# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update timelines' do
  subject { V1::Timelines::UpdateRepository.new(update_params).update }

  let(:timeline) { create(:timeline) }
  let(:update_params) do
    { timeline: timeline,
      author_id: nil }
  end

  describe 'fail by validation' do
    it do
      expect(subject[:error]).to eq("Validation failed: Title can't be blank")
    end
  end
end
