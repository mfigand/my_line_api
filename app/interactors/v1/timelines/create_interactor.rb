# frozen_string_literal: true

module V1
  module Timelines
    class CreateInteractor
      def initialize(create_params)
        @author_id = create_params[:author_id]
        @protagonist_email = create_params[:protagonist_email]
        @title = create_params[:title]
      end

      def create
        if timeline.instance_of?(Timeline)
          { data: ::V1::Timelines::ShowPresenter.new(timeline).serialize, status: 200 }
        else
          { data: "Error: #{timeline[:error]}", status: :unprocessable_entity }
        end
      end

      private

      def timeline
        @timeline ||= ::V1::Timelines::CreateRepository.new(create_params).create
      end

      def protagonist
        @protagonist ||= ::V1::Users::FindRepository.new({ email: @protagonist_email }).find
      end

      def create_params
        if protagonist.instance_of?(User)
          instance_values.merge('protagonist_id' => protagonist.id)
        else
          instance_values
        end
      end
    end
  end
end
