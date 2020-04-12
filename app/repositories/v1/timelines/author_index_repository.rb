# frozen_string_literal: true

module V1
  module Timelines
    class AuthorIndexRepository
      def initialize(author)
        @author = author
      end

      def index
        @author.created_timelines
      end
    end
  end
end
