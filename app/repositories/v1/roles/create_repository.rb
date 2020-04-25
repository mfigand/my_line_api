# frozen_string_literal: true

module V1
  module Roles
    class CreateRepository
      def initialize(create_params)
        @name = create_params['name']
        @resource = create_params['resource']
        @resource_id = create_params['resource_id']
      end

      def create
        Role.create!(instance_values)
      rescue ActiveRecord::RecordInvalid, ArgumentError => e
        { error: e.message }
      end
    end
  end
end
