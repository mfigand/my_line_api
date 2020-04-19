# frozen_string_literal: true

module V1
  module Stories
    class DestroyInteractor
      def initialize(current_user, story_id)
        @current_user = current_user
        @story_id = story_id
      end

      def destroy
        return ErrorService.new(story[:error], :not_found).create unless story.instance_of?(Story)
        return ApplicationPolicy.unauthorized_error unless allowed?

        { data: ::V1::Stories::DestroyRepository.new(story).destroy, status: :no_content }
      end

      private

      def allowed?
        StoryPolicy.new(@current_user, story).destroy?
      end

      def story
        @story ||= ::V1::Stories::FindRepository.new(@story_id).find
      end
    end
  end
end
