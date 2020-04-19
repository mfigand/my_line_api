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
      rescue ActiveRecord::RecordInvalid => e
        { error: e.message }
      end
    end
  end
end
