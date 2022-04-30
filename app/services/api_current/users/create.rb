# frozen_string_literal: true

module ApiCurrent
  module Users
    class Create
      include Dry::Monads[:result, :do]

      include Udatapp::Import[contract: 'contracts.api_current.sessions.authenticate_user_contract']

      # @param params [Hash]
      #
      # @return [Dry::Monads::Result<Hash, Symbol>]
      def call(params:)
        form = yield contract.call(params)

        yield create_user!(form.to_h)

        Success({})
      end

      private

      def create_user!(attributes)
        user = User.new(attributes)

        user.save ? Success() : Failure(user.errors.to_h)
      end
    end
  end
end
