# frozen_string_literal: true

module V1
  module Stories
    class ShowPresenter
      def initialize(story)
        @story = story
      end

      def serialize
        @story.instance_of?(Story) ? serialized_story : {}
      end

      private

      def serialized_story
        @story.slice(:id, :title, :date, :protagonist_id, :teller_id, :teller_title,
                     :timeline_id, :tags, :description, :created_at, :updated_at)
      end
    end
  end
end
