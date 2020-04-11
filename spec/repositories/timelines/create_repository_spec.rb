# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create timelines' do
  subject { V1::Timelines::CreateRepository.new(create_params).create }

  let(:author) { create(:user) }
  let(:author_id) { author.id }
  let(:protagonist) { create(:user) }
  let(:title) { 'timeline_title' }
  let(:create_params) do
    { 'author_id' => author_id,
      'protagonist_id' => protagonist.id,
      'title' => title }
  end

  describe '#create' do
    it do
      expect(subject).to be_a_kind_of(Timeline)
      expect(subject.id).to be_a_kind_of(Integer)
      expect(subject.attributes).to include('author_id' => author.id,
                                            'protagonist_id' => protagonist.id,
                                            'title' => title)
    end
  end

  describe 'fail by validation' do
    let(:author_id) { '' }

    it do
      expect(subject[:error]).to eq("Validation failed: Author must exist, Author can't be blank")
    end
  end
end