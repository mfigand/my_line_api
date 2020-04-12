# frozen_string_literal: true

module V1
  module Timelines
    class ProtagonistIndexRepository
      def initialize(protagonist)
        @protagonist = protagonist
      end

      def index
        @protagonist.timelines
      end
    end
  end
end
