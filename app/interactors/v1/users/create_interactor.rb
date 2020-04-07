# frozen_string_literal: true

module V1
  module Users
    class CreateInteractor
      def initialize(create_params)
        @name = create_params[:name]
        @lastname = create_params[:lastname]
        @email = create_params[:email]
        @password = create_params[:password]
      end

      def create
        if user&.try(:authenticate, @password)
          { data: ::V1::Users::ShowPresenter.new(user).serialize, status: 200 }
        else
          { data: "Error: #{user[:error]}", status: :unprocessable_entity }
        end
      end

      private

      def user
        @user ||= ::V1::Users::CreateRepository.new(instance_values).create
      end
    end
  end
end
