# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:story) { build(:story) }

  describe 'validations' do
    it 'Create a valid story' do
      expect(create(:story)).to be_valid
    end

    it 'Validwithout protagonist' do
      expect(build(:story, protagonist: nil)).to be_valid
    end

    it 'Invalidwithout author' do
      expect(build(:story, author: nil)).not_to be_valid
    end
  end
end
