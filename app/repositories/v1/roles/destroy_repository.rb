# frozen_string_literal: true

module V1
  module Roles
    class DestroyRepository
      def initialize(role)
        @role = role
      end

      def destroy
        @role.destroy!
        true
      end
    end
  end
end
