# frozen_string_literal: true

module Api
  module V1
    class TimelinesController < ApplicationController
      before_action :authenticate_user
      before_action :validate_schema

      def author_index
        index = ::V1::Timelines::AuthorIndexInteractor.new(current_user).index
        json_response(index)
      end

      def protagonist_index
        index = ::V1::Timelines::ProtagonistIndexInteractor.new(current_user).index
        json_response(index)
      end

      def create
        created = ::V1::Timelines::CreateInteractor.new(safe_params).create
        json_response(created)
      end

      def show
        shown = ::V1::Timelines::ShowInteractor.new(current_user,
                                                    safe_params[:id]).show
        json_response(shown)
      end

      def update
        updated = ::V1::Timelines::UpdateInteractor.new(current_user,
                                                        safe_params).update
        json_response(updated)
      end

      def destroy
        destroyed = ::V1::Timelines::DestroyInteractor.new(current_user,
                                                           safe_params[:id]).destroy
        json_response(destroyed)
      end

      private

      def json_response(result)
        render json: { data: result[:data] }, status: result[:status]
      end

      def safe_params
        params.permit(:id, :author_id, :protagonist_id, :protagonist_email, :title)
      end

      def validate_schema
        valid = JsonSchemaService.new(action_name, controller_name, safe_params.to_hash).validate
        json_response(valid) unless valid == true
      end
    end
  end
end
