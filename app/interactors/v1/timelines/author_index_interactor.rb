# frozen_string_literal: true

module V1
  module Timelines
    class AuthorIndexInteractor
      def initialize(create_params)
        @author_id = create_params[:author_id]
      end

      def index
        return ErrorService.new(author[:error], :not_found).create unless author.instance_of?(User)

        { data: ::V1::Timelines::IndexPresenter.new(timelines).serialize, status: 200 }
      end

      private

      def timelines
        @timelines ||= ::V1::Timelines::AuthorIndexRepository.new(author).index
      end

      def author
        @author ||= ::V1::Users::FindRepository.new({ id: @author_id }).find
      end
    end
  end
end
