# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pagination service' do
  subject { PaginationService.new(collection, page).paginate }

  let(:user) { create(:user) }
  let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
  let(:timeline) { user.created_timelines.create(title: 'Timeline') }
  let(:collection) do
    5.times do |index|
      user.told_stories.create(date: Time.now.utc - index.days, timeline: timeline)
    end
    Story.all
  end

  describe 'show pagination info' do
    let(:page) { 1 }

    it do
      expect(subject[:total_records]).to eq(collection.count)
      expect(subject[:records_per_page]).to eq(collection.page(page).default_per_page)
      expect(subject[:total_pages]).to eq(collection.page(page).total_pages)
      expect(subject[:current_page]).to eq(collection.page(page).current_page)
      expect(subject[:next_page]).to eq(collection.page(page).next_page)
      expect(subject[:prev_page]).to eq(collection.page(page).prev_page)
      expect(subject[:is_first_page]).to eq(collection.page(page).first_page?)
      expect(subject[:is_last_page]).to eq(collection.page(page).last_page?)
      expect(subject[:out_of_range]).to eq(collection.page(page).out_of_range?)
    end
  end
end
