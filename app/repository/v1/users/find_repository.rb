# frozen_string_literal: true

module V1
  module Users
    class FindRepository
      def initialize(params)
        @params = params
      end

      def find
        User.find_by!(@params)
      rescue ActiveRecord::RecordNotFound => e
        { error: e.message }
      end
    end
  end
end
