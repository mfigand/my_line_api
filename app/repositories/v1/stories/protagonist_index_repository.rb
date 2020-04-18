# frozen_string_literal: true

module V1
  module Stories
    class ProtagonistIndexRepository
      def initialize(protagonist)
        @protagonist = protagonist
      end

      def index
        @protagonist.stories
      end
    end
  end
end
