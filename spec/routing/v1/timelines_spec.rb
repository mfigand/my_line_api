# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'timelines routing' do
  let(:controller) { 'api/v1/timelines' }
  let(:timeline) { create(:timeline) }
  let(:author) { timeline.author }

  it '#author_index' do
    expect(get: api_v1_timelines_author_index_path)
      .to route_to(controller: controller,
                   action: 'author_index')
  end

  it '#protagonist_index' do
    expect(get: api_v1_timelines_protagonist_index_path)
      .to route_to(controller: controller,
                   action: 'protagonist_index')
  end

  it '#create' do
    expect(post: api_v1_timelines_path)
      .to route_to(controller: controller,
                   action: 'create')
  end

  it '#show' do
    expect(get: api_v1_timeline_path(timeline))
      .to route_to(controller: controller,
                   action: 'show',
                   id: timeline.id.to_s)
  end

  it '#update' do
    expect(patch: api_v1_timeline_path(timeline))
      .to route_to(controller: controller,
                   action: 'update',
                   id: timeline.id.to_s)
  end

  it '#destroy' do
    expect(delete: api_v1_timeline_path(timeline))
      .to route_to(controller: controller,
                   action: 'destroy',
                   id: timeline.id.to_s)
  end
end
