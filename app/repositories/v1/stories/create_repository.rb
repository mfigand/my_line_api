# frozen_string_literal: true

module V1
  module Stories
    class CreateRepository
      def initialize(create_params)
        @title = create_params['title']
        @date = create_params['date']
        @teller_id = create_params['teller'].id
        @teller_title = create_params['teller_title']
        @timeline_id = create_params['timeline_id']
        @tags = create_params['tags']
        @description = create_params['description']
      end

      def create
        Story.create!(instance_values)
      rescue ActiveRecord::RecordInvalid, ArgumentError => e
        { error: e.message }
      end
    end
  end
end
