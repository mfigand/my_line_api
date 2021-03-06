# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, except: [:create]
      before_action :validate_schema

      def create
        created = ::V1::Users::CreateInteractor.new(safe_params).create
        json_response(created)
      end

      def show
        shown = ::V1::Users::ShowInteractor.new(current_user,
                                                safe_params[:id]).show
        json_response(shown)
      end

      def update
        updated = ::V1::Users::UpdateInteractor.new(current_user,
                                                    safe_params[:id],
                                                    update_params).update
        json_response(updated)
      end

      def destroy
        destroyed = ::V1::Users::DestroyInteractor.new(current_user,
                                                       safe_params[:id]).destroy
        json_response(destroyed)
      end

      private

      def json_response(result)
        render json: { data: result[:data] }, status: result[:status]
      end

      def safe_params
        params.permit(:id, :name, :lastname, :email, :password)
      end

      def update_params
        to_update = safe_params.to_hash
        to_update.delete('id')
        to_update
      end

      def validate_schema
        valid = JsonSchemaService.new(action_name, controller_name, safe_params.to_hash).validate
        json_response(valid) unless valid == true
      end
    end
  end
end
