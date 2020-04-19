# frozen_string_literal: true

module V1
  module Stories
    class TellerIndexInteractor
      def initialize(teller)
        @teller = teller
      end

      def index
        { data: ::V1::Stories::IndexPresenter.new(stories).serialize, status: 200 }
      end

      private

      def stories
        @stories ||= ::V1::Stories::TellerIndexRepository.new(@teller).index
      end
    end
  end
end
