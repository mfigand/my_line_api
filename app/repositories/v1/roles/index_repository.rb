# frozen_string_literal: true

module V1
  module Roles
    class IndexRepository
      def initialize(user)
        @user = user
      end

      def index
        @user.roles
      end
    end
  end
end
