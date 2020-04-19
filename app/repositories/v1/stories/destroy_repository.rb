# frozen_string_literal: true

module V1
  module Stories
    class DestroyRepository
      def initialize(story)
        @story = story
      end

      def destroy
        @story.destroy!
        true
      end
    end
  end
end
