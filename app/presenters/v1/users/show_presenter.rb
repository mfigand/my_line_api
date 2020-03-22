# frozen_string_literal: true

module V1
  module Users
    class ShowPresenter
      def initialize(user)
        @user = user
      end

      def serialize
        @user.instance_of?(User) ? serialized_user : {}
      end

      private

      def serialized_user
        @user.slice(:id, :name, :lastname, :email, :created_at, :updated_at)
      end
    end
  end
end
