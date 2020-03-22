# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit

  def authenticate_user
    render json: true, status: :unauthorized unless auth_token
  end

  def current_user
    @current_user ||= ::V1::Users::FindRepository.new({ id: user_id }).find if user_id
  end

  private

  def auth_token
    @auth_token ||= JsonWebToken.decode(request.headers[:Authentication])
  end

  def user_id
    @user_id ||= auth_token[:user_id]
  end
end
