# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'stories routing' do
  let(:controller) { 'api/v1/stories' }
  let(:story) { create(:story) }
  let(:teller) { story.teller }

  it do
    expect(get: api_v1_stories_teller_index_path(teller))
      .to route_to(controller: controller,
                   action: 'teller_index',
                   teller_id: teller.id.to_s)
  end

  it do
    expect(get: api_v1_stories_protagonist_index_path(teller))
      .to route_to(controller: controller,
                   action: 'protagonist_index',
                   protagonist_id: teller.id.to_s)
  end

  it do
    expect(post: api_v1_user_stories_path(teller))
      .to route_to(controller: controller,
                   action: 'create',
                   user_id: teller.id.to_s)
  end

  it do
    expect(get: api_v1_user_story_path(teller, story))
      .to route_to(controller: controller,
                   action: 'show',
                   user_id: teller.id.to_s,
                   id: story.id.to_s)
  end

  it do
    expect(patch: api_v1_user_story_path(teller, story))
      .to route_to(controller: controller,
                   action: 'update',
                   user_id: teller.id.to_s,
                   id: story.id.to_s)
  end

  it do
    expect(delete: api_v1_user_story_path(teller, story))
      .to route_to(controller: controller,
                   action: 'destroy',
                   user_id: teller.id.to_s,
                   id: story.id.to_s)
  end
end
