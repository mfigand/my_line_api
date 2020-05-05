# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'stories routing' do
  let(:controller) { 'api/v1/stories' }
  let(:story) { create(:story) }
  let(:timeline) { story.timeline }
  let(:teller) { story.teller }

  it '#teller_index' do
    expect(get: api_v1_stories_teller_index_path(teller))
      .to route_to(controller: controller,
                   action: 'teller_index',
                   teller_id: teller.id.to_s)
  end

  it '#protagonist_index' do
    expect(get: api_v1_stories_protagonist_index_path(teller))
      .to route_to(controller: controller,
                   action: 'protagonist_index',
                   protagonist_id: teller.id.to_s)
  end

  it '#index' do
    expect(get: api_v1_timeline_stories_path(timeline))
      .to route_to(controller: controller,
                   action: 'index',
                   timeline_id: timeline.id.to_s)
  end

  it '#create' do
    expect(post: api_v1_timeline_stories_path(timeline))
      .to route_to(controller: controller,
                   action: 'create',
                   timeline_id: timeline.id.to_s)
  end

  it '#show' do
    expect(get: api_v1_timeline_story_path(timeline, story))
      .to route_to(controller: controller,
                   action: 'show',
                   timeline_id: timeline.id.to_s,
                   id: story.id.to_s)
  end

  it '#update' do
    expect(patch: api_v1_timeline_story_path(timeline, story))
      .to route_to(controller: controller,
                   action: 'update',
                   timeline_id: timeline.id.to_s,
                   id: story.id.to_s)
  end

  it '#destroy' do
    expect(delete: api_v1_timeline_story_path(timeline, story))
      .to route_to(controller: controller,
                   action: 'destroy',
                   timeline_id: timeline.id.to_s,
                   id: story.id.to_s)
  end
end
