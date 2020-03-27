# frozen_string_literal: true

module V1
  module Users
    class DestroyInteractor
      def initialize(current_user, id)
        @current_user = current_user
        @id = id
      end

      def destroy
        return ErrorService.new(user[:error], :not_found).create unless user.instance_of?(User)
        return ApplicationPolicy.unauthorized_error unless allowed?
        return ErrorService.new(updated_user[:error], :unprocessable_entity).create unless deleted_user.instance_of?(User)

        { data: '', status: :no_content }
      end

      private

      def allowed?
        UserPolicy.new(@current_user, user).destroy?
      end

      def user
        @user ||= ::V1::Users::FindRepository.new({ id: @id }).find
      end

      def deleted_user
        @deleted_user ||= ::V1::Users::DestroyRepository.new(user).destroy
      end
    end
  end
end
