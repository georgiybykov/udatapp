# frozen_string_literal: true

module Sessions
  class AuthorizeApiRequest
    include Dry::Monads[:result, :do]

    # @param auth_header [String]
    #
    # @return [Dry::Monads::Result<User, Symbol>]
    def call(auth_header:)
      decoded_auth_token = yield decode(auth_header)

      find_user(decoded_auth_token[:user_id])
    end

    private

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]

      Success(
        HashWithIndifferentAccess.new(body)
      )
    rescue JWT::DecodeError, JWT::ExpiredSignature
      Failure(:invalid_access_token)
    end

    def find_user(user_id)
      user = User.find_by(id: user_id)

      return Failure(:user_not_found) unless user

      Success()
    end
  end
end
