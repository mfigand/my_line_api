# frozen_string_literal: true

module V1
  module Timelines
    class DestroyInteractor
      def initialize(current_user, timeline_id)
        @current_user = current_user
        @timeline_id = timeline_id
      end

      def destroy
        return ErrorService.new(timeline[:error], :not_found).create unless timeline.instance_of?(Timeline)
        return ApplicationPolicy.unauthorized_error unless allowed?

        { data: ::V1::Timelines::DestroyRepository.new(timeline).destroy, status: :no_content }
      end

      private

      def allowed?
        TimelinePolicy.new(@current_user, timeline).destroy?
      end

      def timeline
        @timeline ||= ::V1::Timelines::FindRepository.new(@timeline_id).find
      end
    end
  end
end
