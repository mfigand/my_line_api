# frozen_string_literal: true

module V1
  module Timelines
    class CreateRepository
      def initialize(create_params)
        @title = create_params['title']
        @author_id = create_params['author_id']
        @protagonist_id = create_params['protagonist_id']
      end

      def create
        Timeline.create!(instance_values)
      rescue ActiveRecord::RecordInvalid => e
        { error: e.message }
      end
    end
  end
end
