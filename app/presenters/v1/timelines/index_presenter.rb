# frozen_string_literal: true

module V1
  module Timelines
    class IndexPresenter
      def initialize(timelines)
        @timelines = timelines
      end

      def serialize
        @timelines.present? ? serialized_timelines : {}
      end

      private

      def serialized_timelines
        @timelines.map do |timeline|
          timeline.slice(:id, :author_id, :protagonist_id, :title, :created_at, :updated_at)
        end
      end
    end
  end
end
