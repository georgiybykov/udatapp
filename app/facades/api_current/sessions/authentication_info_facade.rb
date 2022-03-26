# frozen_string_literal: true

module ApiCurrent
  module Sessions
    class AuthenticationInfoFacade
      # @return [String]
      attr_reader :access_token

      def initialize(access_token:, expiration_time:)
        @access_token = access_token
        @expiration_time = expiration_time
      end

      def expires_at
        expiration_time.iso8601
      end

      private

      # @return [ActiveSupport::TimeWithZone]
      attr_reader :expiration_time
    end
  end
end
