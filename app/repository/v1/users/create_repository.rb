# frozen_string_literal: true

module V1
  module Users
    class CreateRepository
      def initialize(email, password)
        @email = email
        @password = password
      end

      def create
        User.create!(instance_values)
      rescue ActiveRecord::RecordInvalid => e
        { error: e.message }
      end
    end
  end
end
