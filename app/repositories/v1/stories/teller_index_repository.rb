# frozen_string_literal: true

module V1
  module Stories
    class TellerIndexRepository
      def initialize(teller)
        @teller = teller
      end

      def index
        @teller.told_stories
      end
    end
  end
end
