# frozen_string_literal: true

module V1
  module Roles
    class ShowPresenter
      def initialize(role)
        @role = role
      end

      def serialize
        @role.instance_of?(Role) ? serialized_role : {}
      end

      private

      def serialized_role
        @role.slice(:id, :name, :resource, :resource_id, :created_at, :updated_at)
      end
    end
  end
end
