# frozen_string_literal: true

module V1
  module Stories
    class IndexPresenter
      def initialize(stories)
        @stories = stories
      end

      def serialize
        @stories.present? ? serialized_stories : {}
      end

      private

      def serialized_stories
        @stories.map do |timeline|
          timeline.slice(:id, :title, :date, :protagonist_id, :teller_id,
                         :teller_title, :timeline_id, :tags, :description,
                         :created_at, :updated_at)
        end
      end
    end
  end
end
