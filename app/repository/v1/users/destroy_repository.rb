# frozen_string_literal: true

module V1
  module Users
    class DestroyRepository
      def initialize(user)
        @user = user
      end

      def destroy
        @user.destroy!
        nil
      rescue ActiveRecord::RecordNotDestroyed => e
        { error: e.message }
      end
    end
  end
end
