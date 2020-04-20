# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update timelines' do
  subject { V1::Timelines::UpdateInteractor.new(author, update_params).update }

  let(:author) { create(:user) }
  let(:timeline) { create(:timeline, author: author) }
  let(:update_params) do
    { title: '',
      id: timeline.id }
  end

  describe 'fail by validation' do
    it do
      expect(subject[:status]).to eq(:unprocessable_entity)
      expect(subject[:data]).to eq("Error: Validation failed: Title can't be blank")
    end
  end
end
