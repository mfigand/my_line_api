# frozen_string_literal: true

module V1
  module Users
    class CreateRepository
      def initialize(create_params)
        @name = create_params['name']
        @lastname = create_params['lastname']
        @email = create_params['email']
        @password = create_params['password']
      end

      def create
        User.create!(instance_values)
      rescue ActiveRecord::RecordInvalid => e
        { error: e.message }
      end
    end
  end
end
