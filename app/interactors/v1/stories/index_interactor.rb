# frozen_string_literal: true

module V1
  module Stories
    class IndexInteractor
      def initialize(current_user, timeline_id)
        @current_user = current_user
        @timeline_id = timeline_id
      end

      def index
        return ErrorService.new(timeline[:error], :not_found).create unless timeline.instance_of?(Timeline)
        return ApplicationPolicy.unauthorized_error unless allowed?

        { data: ::V1::Stories::IndexPresenter.new(stories).serialize, status: 200 }
      end

      private

      def allowed?
        StoryPolicy.new(@current_user, timeline).index?
      end

      def timeline
        @timeline ||= ::V1::Timelines::FindRepository.new(@timeline_id).find
      end

      def stories
        @stories ||= ::V1::Stories::IndexRepository.new(timeline).index
      end
    end
  end
end
