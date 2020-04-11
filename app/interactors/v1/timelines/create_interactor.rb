# frozen_string_literal: true

module V1
  module Timelines
    class CreateInteractor
      def initialize(create_params)
        @author_id = create_params[:author_id]
        @protagonist_id = create_params[:protagonist_id]
        @title = create_params[:title]
      end

      def create
        if timeline
          { data: ::V1::Timelines::ShowPresenter.new(timeline).serialize, status: 200 }
        else
          { data: "Error: #{timeline[:error]}", status: :unprocessable_entity }
        end
      end

      private

      def timeline
        @timeline ||= ::V1::Timelines::CreateRepository.new(instance_values).create
      end
    end
  end
end
