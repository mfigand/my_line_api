# frozen_string_literal: true

module V1
  module Stories
    class AuthorIndexRepository
      def initialize(author)
        @author = author
      end

      def index
        @author.told_stories
      end
    end
  end
end
