# frozen_string_literal: true

module Sessions
  class AuthenticateUser
    def call(email:, password:)
      user = find_user(email, password)

      return { user_authentication: ['invalid credentials'] } unless user

      encode(payload: { user_id: user.id }) if user.is_a?(User)
    end

    private

    def find_user(email, password)
      user = User.find_by(email: email)

      return user if user.present? && user.authenticate(password)

      false
    end

    def encode(payload:, expires_at: 24.hours.from_now)
      payload[:exp] = expires_at.to_i

      {
        auth_token: JWT.encode(payload, Rails.application.secrets.secret_key_base),
        expires_at: expires_at
      }
    end
  end
end
