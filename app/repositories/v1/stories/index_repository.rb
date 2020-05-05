# frozen_string_literal: true

module V1
  module Stories
    class IndexRepository
      def initialize(timeline)
        @timeline = timeline
      end

      def index
        @timeline.stories
      end
    end
  end
end
