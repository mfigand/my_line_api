# frozen_string_literal: true

module V1
  module Timelines
    class ProtagonistIndexInteractor
      def initialize(protagonist)
        @protagonist = protagonist
      end

      def index
        { data: ::V1::Timelines::IndexPresenter.new(timelines).serialize, status: 200 }
      end

      private

      def timelines
        @timelines ||= ::V1::Timelines::ProtagonistIndexRepository.new(@protagonist).index
      end
    end
  end
end
