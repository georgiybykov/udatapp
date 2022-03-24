# frozen_string_literal: true

module Sessions
  class AuthenticationInfoSerializer < BaseSerializer
    json_schema do
      {
        access_token: Types::Strict::String,
        expires_at: Types::Strict::String
      }
    end
  end
end
