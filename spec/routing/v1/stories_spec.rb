# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'stories routing' do
  let(:controller) { 'api/v1/stories' }
  let(:story) { create(:story) }
  let(:author) { story.author }

  it do
    expect(get: api_v1_stories_author_index_path(author))
      .to route_to(controller: controller,
                   action: 'author_index',
                   author_id: author.id.to_s)
  end

  it do
    expect(get: api_v1_stories_protagonist_index_path(author))
      .to route_to(controller: controller,
                   action: 'protagonist_index',
                   protagonist_id: author.id.to_s)
  end

  it do
    expect(post: api_v1_user_stories_path(author))
      .to route_to(controller: controller,
                   action: 'create',
                   user_id: author.id.to_s)
  end

  it do
    expect(get: api_v1_user_story_path(author, story))
      .to route_to(controller: controller,
                   action: 'show',
                   user_id: author.id.to_s,
                   id: story.id.to_s)
  end

  it do
    expect(patch: api_v1_user_story_path(author, story))
      .to route_to(controller: controller,
                   action: 'update',
                   user_id: author.id.to_s,
                   id: story.id.to_s)
  end

  it do
    expect(delete: api_v1_user_story_path(author, story))
      .to route_to(controller: controller,
                   action: 'destroy',
                   user_id: author.id.to_s,
                   id: story.id.to_s)
  end
end
