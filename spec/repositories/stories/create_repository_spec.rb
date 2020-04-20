# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create stories' do
  subject { V1::Stories::CreateRepository.new(create_params).create }

  let(:create_params) do
    { 'teller' => create(:user),
      'date' => nil,
      'teller_id' => nil }
  end
  let(:error) do
    "Validation failed: Timeline must exist, Date can't be blank, Timeline can't be blank"
  end

  describe 'fail by validation' do
    it do
      expect(subject[:error]).to eq(error)
    end
  end
end
