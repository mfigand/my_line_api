# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    it 'Create a valid' do
      expect(create(:user)).to be_valid
    end

    it 'Invalidwithout a email' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it 'Invalidwithout a password' do
      expect(build(:user, password: nil)).not_to be_valid
    end
  end
end
