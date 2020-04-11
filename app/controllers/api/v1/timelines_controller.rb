# frozen_string_literal: true

module Api
  module V1
    class TimelinesController < ApplicationController
      before_action :authenticate_user
      before_action :validate_schema

      def index; end

      def create
        created = ::V1::Timelines::CreateInteractor.new(safe_params).create
        json_response(created)
      end

      def show; end

      def update; end

      def destroy; end

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
