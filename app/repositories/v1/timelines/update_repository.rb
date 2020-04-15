# frozen_string_literal: true

module V1
  module Timelines
    class UpdateRepository
      def initialize(update_params)
        @timeline = update_params[:timeline]
        @title = update_params[:title]
        @protagonist_id = update_params[:protagonist_id]
      end

      def update
        @timeline.update!(title: @title, protagonist_id: @protagonist_id)
        @timeline
      rescue ActiveRecord::RecordInvalid => e
        { error: e.message }
      end
    end
  end
end
