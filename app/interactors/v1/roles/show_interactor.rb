# frozen_string_literal: true

module V1
  module Roles
    class ShowInteractor
      def initialize(current_user, role_id)
        @current_user = current_user
        @role_id = role_id
      end

      def show
        return ErrorService.new(role[:error], :not_found).create unless role.instance_of?(Role)
        return ApplicationPolicy.unauthorized_error unless allowed?

        { data: ::V1::Roles::ShowPresenter.new(role).serialize, status: 200 }
      end

      private

      def allowed?
        RolePolicy.new(@current_user, role).show?
      end

      def role
        @role ||= ::V1::Roles::FindRepository.new(@role_id).find
      end
    end
  end
end
