# frozen_string_literal: true

module V1
  module Stories
    class CreateInteractor
      def initialize(teller, create_params)
        @teller = teller
        @title = create_params[:title]
        @date = create_params[:date]
        @teller_title = create_params[:teller_title]
        @timeline_id = create_params[:timeline_id]
        @tags = create_params[:tags]
        @description = create_params[:description]
      end

      def create
        return ErrorService.new(timeline[:error], :not_found).create unless timeline.instance_of?(Timeline)
        return ApplicationPolicy.unauthorized_error unless allowed?

        if story
          { data: ::V1::Stories::ShowPresenter.new(story).serialize, status: 200 }
        else
          { data: "Error: #{story[:error]}", status: :unprocessable_entity }
        end
      end

      private

      def story
        @story ||= ::V1::Stories::CreateRepository.new(instance_values).create
      end

      def allowed?
        StoryPolicy.new(@teller, timeline).create?
      end

      def timeline
        @timeline ||= ::V1::Timelines::FindRepository.new(@timeline_id).find
      end
    end
  end
end
