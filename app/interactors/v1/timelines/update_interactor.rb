# frozen_string_literal: true

module V1
  module Timelines
    class UpdateInteractor
      def initialize(current_user, update_params)
        @current_user = current_user
        @timeline_id = update_params[:id]
        @title = update_params[:title]
        @protagonist_id = update_params[:protagonist_id]
      end

      def update
        return ErrorService.new(timeline[:error], :not_found).create unless timeline.instance_of?(Timeline)
        return ApplicationPolicy.unauthorized_error unless allowed?

        if updated_timeline
          { data: ::V1::Timelines::ShowPresenter.new(updated_timeline).serialize, status: 200 }
        else
          { data: "Error: #{updated_timeline[:error]}", status: :unprocessable_entity }
        end
      end

      private

      def allowed?
        TimelinePolicy.new(@current_user, timeline).update?
      end

      def timeline
        @timeline ||= ::V1::Timelines::FindRepository.new(@timeline_id).find
      end

      def allowed_params
        params = { timeline: timeline, title: @title || timeline.title,
                   protagonist_id: @protagonist_id || timeline.protagonist_id }
        params[:protagonist_id] = @current_user.id if @current_user == timeline.protagonist
        params
      end

      def updated_timeline
        @updated_timeline ||= ::V1::Timelines::UpdateRepository.new(allowed_params).update
      end
    end
  end
end
