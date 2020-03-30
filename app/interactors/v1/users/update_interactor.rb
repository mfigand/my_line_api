# frozen_string_literal: true

module V1
  module Users
    class UpdateInteractor
      def initialize(current_user, id, update_attributes)
        @current_user = current_user
        @id = id
        @update_attributes = update_attributes
      end

      def update
        return ErrorService.new(user[:error], :not_found).create unless user.instance_of?(User)
        return ApplicationPolicy.unauthorized_error unless allowed?
        unless updated_user.instance_of?(User)
          return ErrorService.new(updated_user[:error], :unprocessable_entity).create
        end

        { data: ::V1::Users::ShowPresenter.new(updated_user).serialize, status: 200 }
      end

      private

      def allowed?
        UserPolicy.new(@current_user, user).update?
      end

      def user
        @user ||= ::V1::Users::FindRepository.new({ id: @id }).find
      end

      def updated_user
        @updated_user ||= ::V1::Users::UpdateRepository.new(user, @update_attributes).update
      end
    end
  end
end
