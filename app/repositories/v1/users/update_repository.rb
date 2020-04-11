# frozen_string_literal: true

module V1
  module Users
    class UpdateRepository
      def initialize(user, update_attributes)
        @user = user
        @update_attributes = update_attributes
      end

      def update
        @user.update!(@update_attributes)
        @user
      rescue ActiveRecord::RecordInvalid => e
        { error: e.message }
      end
    end
  end
end
