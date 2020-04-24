# frozen_string_literal: true

module V1
  module Roles
    class IndexInteractor
      def initialize(user)
        @user = user
      end

      def index
        { data: ::V1::Roles::IndexPresenter.new(roles).serialize, status: 200 }
      end

      private

      def roles
        @roles ||= ::V1::Roles::IndexRepository.new(@user).index
      end
    end
  end
end
