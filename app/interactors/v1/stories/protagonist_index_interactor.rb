# frozen_string_literal: true

module V1
  module Stories
    class ProtagonistIndexInteractor
      def initialize(protagonist)
        @protagonist = protagonist
      end

      def index
        { data: ::V1::Stories::IndexPresenter.new(stories).serialize, status: 200 }
      end

      private

      def stories
        @stories ||= ::V1::Stories::ProtagonistIndexRepository.new(@protagonist).index
      end
    end
  end
end
