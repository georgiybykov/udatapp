# frozen_string_literal: true

module Sessions
  class AuthenticateUserContract < BaseContract
    SIMPLE_EMAIL_REGEXP = /\A[^@\s]+@[^@\s]+\z/.freeze

    json do
      required(:email).filled(Types::StrippedString)
      required(:password).filled(:string)
    end

    rule(:email) do
      key.failure('email format is invalid') if invalid_email?(value)
    end

    private

    def invalid_email?(email)
      !SIMPLE_EMAIL_REGEXP.match?(email)
    end
  end
end
