# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'timelines routing' do
  let(:controller) { 'api/v1/timelines' }
  let(:timeline) { create(:timeline) }
  let(:author) { timeline.author }

  it do
    expect(get: api_v1_author_index_path(author))
      .to route_to(controller: controller,
                   action: 'author_index',
                   author_id: author.id.to_s)
  end

  it do
    expect(get: api_v1_protagonist_index_path(author))
      .to route_to(controller: controller,
                   action: 'protagonist_index',
                   protagonist_id: author.id.to_s)
  end

  it do
    expect(post: api_v1_user_timelines_path(author))
      .to route_to(controller: controller,
                   action: 'create',
                   user_id: author.id.to_s)
  end

  it do
    expect(get: api_v1_user_timeline_path(author, timeline))
      .to route_to(controller: controller,
                   action: 'show',
                   user_id: author.id.to_s,
                   id: timeline.id.to_s)
  end

  it do
    expect(patch: api_v1_user_timeline_path(author, timeline))
      .to route_to(controller: controller,
                   action: 'update',
                   user_id: author.id.to_s,
                   id: timeline.id.to_s)
  end

  it do
    expect(delete: api_v1_user_timeline_path(author, timeline))
      .to route_to(controller: controller,
                   action: 'destroy',
                   user_id: author.id.to_s,
                   id: timeline.id.to_s)
  end
end
