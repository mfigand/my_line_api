# frozen_string_literal: true

module V1
  class AuthenticateInteractor
    def initialize(email, password)
      @email = email
      @password = password
    end

    def resolve
      if user&.try(:authenticate, @password)
        { data: JsonWebToken.encode(user_id: user.id), status: 200 }
      else
        { data: "Invalid credentials - #{user[:error]}", status: :unauthorized }
      end
    end

    private

    def user
      @user ||= ::V1::Users::FindRepository.new({ email: @email }).find
    end
  end
end
