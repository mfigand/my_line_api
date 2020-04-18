# frozen_string_literal: true

module V1
  module Stories
    class AuthorIndexInteractor
      def initialize(author)
        @author = author
      end

      def index
        { data: ::V1::Stories::IndexPresenter.new(stories).serialize, status: 200 }
      end

      private

      def stories
        @stories ||= ::V1::Stories::AuthorIndexRepository.new(@author).index
      end
    end
  end
end
