# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimelinesTeller, type: :model do
  let(:timelines_teller) { create(:timelines_teller) }

  describe 'validations' do
    it 'Create a valid timelines_teller' do
      expect(timelines_teller).to be_valid
    end

    it 'Invalidwith same scope' do
      expect(build(:timelines_teller, timeline_id: timelines_teller.timeline_id,
                                      teller_id: timelines_teller.teller_id)).not_to be_valid
    end
  end
end
