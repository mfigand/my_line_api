# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroy timelines' do
  subject { V1::Timelines::DestroyRepository.new(timeline).destroy }

  let(:timeline) { create(:timeline) }
  let(:story) { create(:story, timeline_id: timeline.id) }

  before { story }

  describe 'fail by validation' do
    it do
      expect(subject[:error]).to eq('Cannot delete record because of dependent stories')
    end
  end
end
