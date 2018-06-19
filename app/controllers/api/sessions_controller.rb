# frozen_string_literal: true

require 'users/jwt_auth'

module API
  class SessionsController < BaseController
    def create
      user = User.find_by(email: params[:email])

      head(:not_found) && return unless user

      if user.password == params[:password]
        json_response = { token: Users::JWTAuth.token_for_user(user) }
        render json: json_response, status: :created
      else
        head :unauthorized
      end
    end
  end
end
