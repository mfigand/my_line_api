# frozen_string_literal: true

module V1
  module Roles
    class DestroyInteractor
      def initialize(current_user, role_id)
        @current_user = current_user
        @role_id = role_id
      end

      def destroy
        return ErrorService.new(role[:error], :not_found).create unless role.instance_of?(Role)
        return ApplicationPolicy.unauthorized_error unless allowed?

        { data: ::V1::Roles::DestroyRepository.new(role).destroy, status: :no_content }
      end

      private

      def allowed?
        RolePolicy.new(@current_user, role).destroy?
      end

      def role
        @role ||= ::V1::Roles::FindRepository.new(@role_id).find
      end
    end
  end
end
