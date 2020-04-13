# frozen_string_literal: true

module V1
  module Timelines
    class AuthorIndexInteractor
      def initialize(author)
        @author = author
      end

      def index
        { data: ::V1::Timelines::IndexPresenter.new(timelines).serialize, status: 200 }
      end

      private

      def timelines
        @timelines ||= ::V1::Timelines::AuthorIndexRepository.new(@author).index
      end
    end
  end
end
