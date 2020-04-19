# frozen_string_literal: true

module V1
  module Timelines
    class DestroyRepository
      def initialize(timeline)
        @timeline = timeline
      end

      def destroy
        @timeline.destroy!
        true
      rescue ActiveRecord::DeleteRestrictionError => e
        { error: e.message }
      end
    end
  end
end
