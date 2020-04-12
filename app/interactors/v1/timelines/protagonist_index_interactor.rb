# frozen_string_literal: true

module V1
  module Timelines
    class ProtagonistIndexInteractor
      def initialize(create_params)
        @protagonist_id = create_params[:protagonist_id]
      end

      def index
        return ErrorService.new(protagonist[:error], :not_found).create unless protagonist.instance_of?(User)

        { data: ::V1::Timelines::IndexPresenter.new(timelines).serialize, status: 200 }
      end

      private

      def timelines
        @timelines ||= ::V1::Timelines::ProtagonistIndexRepository.new(protagonist).index
      end

      def protagonist
        @protagonist ||= ::V1::Users::FindRepository.new({ id: @protagonist_id }).find
      end
    end
  end
end
