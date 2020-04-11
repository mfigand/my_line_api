# frozen_string_literal: true

module V1
  module Users
    class DestroyRepository
      def initialize(user)
        @user = user
      end

      def destroy
        @user.soft_delete
      end
    end
  end
end
