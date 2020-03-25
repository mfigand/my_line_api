# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline, type: :model do
  let(:timeline) { build(:timeline) }

  describe 'validations' do
    it 'Create a valid timeline' do
      expect(create(:timeline)).to be_valid
    end

    it 'Validwithout protagonist' do
      expect(build(:timeline, protagonist: nil)).to be_valid
    end

    it 'Invalidwithout author' do
      expect(build(:timeline, author: nil)).not_to be_valid
    end
  end
end
