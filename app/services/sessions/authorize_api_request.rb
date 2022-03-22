# frozen_string_literal: true

module Sessions
  class AuthorizeApiRequest
    def call(auth_header:)
      decoded_auth_token = decode(auth_header)

      User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    end

    private

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]

      HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end
  end
end
