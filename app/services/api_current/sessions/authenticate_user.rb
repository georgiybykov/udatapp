# frozen_string_literal: true

module ApiCurrent
  module Sessions
    class AuthenticateUser
      include Dry::Monads[:result, :do]

      include Udatapp::Import[contract: 'contracts.api_current.sessions.authenticate_user_contract']

      # @param params [Hash]
      #
      # @return [Dry::Monads::Result<Hash, Symbol>]
      def call(params:)
        form = yield contract.call(params)

        user = yield find_user(form[:email], form[:password])

        access_token, expiration_time = encode_credentials_for(user)

        serialize_result(access_token, expiration_time)
      end

      private

      def find_user(email, password)
        user = User.find_by(email: email)

        return Failure(:invalid_email) unless user
        return Failure(:invalid_password) unless user.authenticate(password)

        Success(user)
      end

      def encode_credentials_for(user, expires_at: 24.hours.from_now)
        [
          JWT.encode(
            { exp: expires_at.to_i, user_id: user.id },
            Rails.application.secrets.secret_key_base
          ),
          expires_at
        ]
      end

      def serialize_result(access_token, expiration_time)
        Success(
          ApiCurrent::Sessions::AuthenticationInfoFacade
            .new(access_token: access_token, expiration_time: expiration_time)
            .then { ApiCurrent::Sessions::AuthenticationInfoSerializer.new(_1).build_schema }
        )
      end
    end
  end
end
