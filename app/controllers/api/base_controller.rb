# frozen_string_literal: true

require 'users/jwt_auth'

module API
  class BaseController < ActionController::Base
    include Pundit

    protect_from_forgery with: :null_session

    rescue_from Pundit::NotAuthorizedError, with: -> { head :forbidden }

    def paginate(relation:, page:, per_page:)
      relation.offset(page - 1).limit(per_page)
    end

    def current_user
      token = request.headers['AuthorizationUserToken']

      Users::JWTAuth.decode_user_from_token(token)
    end
  end
end
