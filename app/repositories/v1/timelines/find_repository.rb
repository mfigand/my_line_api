# frozen_string_literal: true

module V1
  module Timelines
    class FindRepository
      def initialize(id)
        @id = id
      end

      def find
        Timeline.find_by!(id: @id)
      rescue ActiveRecord::RecordNotFound => e
        { error: e.message }
      end
    end
  end
end
