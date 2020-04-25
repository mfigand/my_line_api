# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create roles' do
  subject { V1::Roles::CreateRepository.new(create_params).create }

  let(:create_params) do
    { 'name' => nil,
      'resource' => nil,
      'resource_id' => nil }
  end
  let(:error) do
    "Validation failed: Name can't be blank"
  end

  describe 'fail by validation' do
    it do
      expect(subject[:error]).to eq(error)
    end
  end
end
