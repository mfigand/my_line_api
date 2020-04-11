# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def authenticate
        authenticated = ::V1::AuthenticateInteractor.new(safe_params[:email], safe_params[:password]).resolve
        render json: { data: authenticated[:data] }, status: authenticated[:status]
      end

      private

      def safe_params
        params.permit(:email, :password)
      end
    end
  end
end
