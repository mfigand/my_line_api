# frozen_string_literal: true

module V1
  module Timelines
    class ShowPresenter
      def initialize(timeline)
        @timeline = timeline
      end

      def serialize
        @timeline.instance_of?(Timeline) ? serialized_timeline : {}
      end

      private

      def serialized_timeline
        @timeline.slice(:id, :title, :author_id, :protagonist_id, :created_at, :updated_at)
      end
    end
  end
end
