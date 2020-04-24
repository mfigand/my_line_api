# frozen_string_literal: true

module V1
  module Roles
    class IndexPresenter
      def initialize(roles)
        @roles = roles
      end

      def serialize
        @roles.present? ? serialized_roles : {}
      end

      private

      def serialized_roles
        @roles.map do |role|
          role.slice(:id, :name, :resource, :resource_id,
                     :created_at, :updated_at)
        end
      end
    end
  end
end
