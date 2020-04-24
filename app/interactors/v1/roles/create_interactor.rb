# frozen_string_literal: true

module V1
  module Roles
    class CreateInteractor
      def initialize(user, create_params)
        @user = user
        @name = create_params[:name]
        @resource = create_params[:resource]
        @resource_id = create_params[:resource_id]
      end

      def create
        return ErrorService.new(timeline[:error], :not_found).create unless timeline.instance_of?(Timeline)
        return ApplicationPolicy.unauthorized_error unless allowed?

        if role.instance_of?(Role)
          { data: ::V1::Roles::ShowPresenter.new(role).serialize, status: 200 }
        else
          { data: "Error: #{role[:error]}", status: :unprocessable_entity }
        end
      end

      private

      def role
        @role ||= ::V1::Roles::CreateRepository.new(instance_values).create
      end

      def allowed?
        RolePolicy.new(@user, timeline).create?
      end

      def timeline
        @timeline ||= ::V1::Timelines::FindRepository.new(@resource_id).find
      end
    end
  end
end
