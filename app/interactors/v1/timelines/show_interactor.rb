# frozen_string_literal: true

module V1
  module Timelines
    class ShowInteractor
      def initialize(current_user, timeline_id)
        @current_user = current_user
        @timeline_id = timeline_id
      end

      def show
        return ErrorService.new(timeline[:error], :not_found).create unless timeline.instance_of?(Timeline)
        return ApplicationPolicy.unauthorized_error unless allowed?

        { data: ::V1::Timelines::ShowPresenter.new(timeline).serialize, status: 200 }
      end

      private

      def allowed?
        TimelinePolicy.new(@current_user, timeline).show?
      end

      def timeline
        @timeline ||= ::V1::Timelines::FindRepository.new(@timeline_id).find
      end
    end
  end
end
