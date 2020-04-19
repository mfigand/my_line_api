# frozen_string_literal: true

module V1
  module Stories
    class UpdateRepository
      def initialize(update_params)
        @story = update_params[:story]
        @title = update_params[:title]
        @date = update_params[:date]
        @teller_title = update_params[:teller_title]
        @tags = update_params[:tags]
        @description = update_params[:description]
      end

      def update
        @story.update!(title: @title, date: @date, teller_title: @teller_title,
                       tags: @tags, description: @description)
        @story
      rescue ActiveRecord::RecordInvalid => e
        { error: e.message }
      end
    end
  end
end
