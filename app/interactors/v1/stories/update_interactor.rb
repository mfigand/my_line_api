# frozen_string_literal: true

module V1
  module Stories
    class UpdateInteractor
      def initialize(current_user, update_params)
        @current_user = current_user
        @story_id = update_params[:id]
        @title = update_params[:title]
        @date = update_params[:date]
        @teller_title = update_params[:teller_title]
        @tags = update_params[:tags]
        @description = update_params[:description]
      end

      def update
        return ErrorService.new(story[:error], :not_found).create unless story.instance_of?(Story)
        return ApplicationPolicy.unauthorized_error unless allowed?

        if updated_story.instance_of?(Story)
          { data: ::V1::Stories::ShowPresenter.new(updated_story).serialize, status: 200 }
        else
          { data: "Error: #{updated_story[:error]}", status: :unprocessable_entity }
        end
      end

      private

      def allowed?
        StoryPolicy.new(@current_user, story).update?
      end

      def story
        @story ||= ::V1::Stories::FindRepository.new(@story_id).find
      end

      def updated_story
        @updated_story ||= ::V1::Stories::UpdateRepository.new(allowed_params).update
      end

      def allowed_params
        { title: @title || story.title, date: @date || story.date,
          teller_title: @teller_title || story.teller_title,
          tags: @tags || story.tags, description: @description || story.description,
          story: story }
      end
    end
  end
end
