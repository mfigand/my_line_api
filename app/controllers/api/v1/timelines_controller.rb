# frozen_string_literal: true

module Api
  module V1
    class TimelinesController < ApplicationController
      before_action :authenticate_user
      before_action :validate_schema

      def author_index
        index = ::V1::Timelines::AuthorIndexInteractor.new(safe_params).index
        json_response(index)
      end

      def protagonist_index
        index = ::V1::Timelines::ProtagonistIndexInteractor.new(safe_params).index
        json_response(index)
      end

      def create
        created = ::V1::Timelines::CreateInteractor.new(safe_params).create
        json_response(created)
      end

      def show
        shown = ::V1::Timelines::ShowInteractor.new(safe_params).show
        json_response(shown)
      end

      def update
        updated = ::V1::Timelines::UpdateInteractor.new(update_params).update
        json_response(updated)
      end

      def destroy
        destroyed = ::V1::Timelines::DestroyInteractor.new(safe_params).destroy
        json_response(destroyed)
      end

      private

      def json_response(result)
        render json: { data: result[:data] }, status: result[:status]
      end

      def safe_params
        params.permit(:id, :author_id, :protagonist_id, :title)
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
