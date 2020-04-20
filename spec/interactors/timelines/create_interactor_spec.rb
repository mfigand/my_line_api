# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create timelines' do
  subject { V1::Timelines::CreateInteractor.new(create_params).create }

  let(:create_params) do
    { author_id: nil }
  end
  let(:error) do
    "Error: Validation failed: Author must exist, Author can't be blank, Title can't be blank"
  end

  describe 'fail by validation' do
    it do
      expect(subject[:status]).to eq(:unprocessable_entity)
      expect(subject[:data]).to eq(error)
    end
  end
end
