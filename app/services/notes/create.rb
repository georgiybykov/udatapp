# frozen_string_literal: true

module Notes
  class Create
    include Dry::Monads[:result, :do]

    include Udatapp::Import[contract: 'contracts.notes.create_note_contract']

    # @param params [Hash]
    # @param current_user [User]
    #
    # @return [Dry::Monads::Result<Hash, Symbol>]
    def call(params:, current_user:)
      form = yield validate!(params)

      create_note!(form, current_user)
    end

    private

    def validate!(params)
      result = contract.call(params)

      return Failure(result.errors.to_h) if result.failure?

      Success(result.to_h)
    end

    def create_note!(attributes, user)
      note = Note.new(attributes.merge(user: user))

      note.save ? Success() : Failure(note.errors.to_h)
    end
  end
end
