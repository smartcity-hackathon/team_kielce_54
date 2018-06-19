# frozen_string_literal: true

# :nocov:

require 'jwt'

module Users
  module JWTAuth
    ALGORITHM = 'HS256'

    def self.token_for_user(user)
      payload = { username: user.username, id: user.id }
      jwt_secret = Rails.application.credentials.jwt_secret_key

      JWT.encode(payload, jwt_secret, ALGORITHM)
    end

    def self.decode_user_from_token(token)
      jwt_secret = Rails.application.credentials.jwt_secret_key

      data = JWT.decode(token, jwt_secret, true, algorithm: ALGORITHM).first
      User.find(data['id'])
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      nil
    end
  end
end
