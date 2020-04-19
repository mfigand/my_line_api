# frozen_string_literal: true

module Api
  module V1
    class StoriesController < ApplicationController
      before_action :authenticate_user
      before_action :validate_schema

      def teller_index
        index = ::V1::Stories::TellerIndexInteractor.new(current_user).index
        json_response(index)
      end

      def protagonist_index
        index = ::V1::Stories::ProtagonistIndexInteractor.new(current_user).index
        json_response(index)
      end

      def create
        created = ::V1::Stories::CreateInteractor.new(current_user,
                                                      safe_params).create
        json_response(created)
      end

      def show
        shown = ::V1::Stories::ShowInteractor.new(current_user,
                                                  safe_params[:id]).show
        json_response(shown)
      end

      # def update
      #   updated = ::V1::Stories::UpdateInteractor.new(current_user,
      #                                                   safe_params).update
      #   json_response(updated)
      # end

      # def destroy
      #   destroyed = ::V1::Stories::DestroyInteractor.new(current_user,
      #                                                       safe_params[:id]).destroy
      #   json_response(destroyed)
      # end

      private

      def json_response(result)
        render json: { data: result[:data] }, status: result[:status]
      end

      def safe_params
        params.permit(:id, :protagonist_id, :teller_id, :user_id, :title,
                      :date, :teller_title, :timeline_id, :tags, :description)
      end

      def validate_schema
        valid = JsonSchemaService.new(action_name, controller_name, safe_params.to_hash).validate
        json_response(valid) unless valid == true
      end
    end
  end
end
