# frozen_string_literal: true

module ApiCurrent
  module Sessions
    class AuthenticateUserContract < BaseContract
      json do
        required(:email).filled(Types::StrippedString)
        required(:password).filled(:string)
      end

      rule(:email) do
        key.failure('email format is invalid') if invalid_email?(value)
      end

      private

      def invalid_email?(email)
        !Common::SIMPLE_EMAIL_REGEXP.match?(email)
      end
    end
  end
end
