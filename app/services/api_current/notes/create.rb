# frozen_string_literal: true

module ApiCurrent
  module Notes
    class Create
      include Dry::Monads[:result, :do]

      include Udatapp::Import[contract: 'contracts.api_current.notes.create_note_contract']

      # @param params [Hash]
      # @param current_user [User]
      #
      # @return [Dry::Monads::Result<Hash, Symbol>]
      def call(params:, current_user:)
        form = yield contract.call(params)

        note = yield create_note!(form.to_h, current_user)

        serialize_result(note)
      end

      private

      def create_note!(attributes, user)
        note = Note.new(attributes.merge(user: user))

        note.save ? Success(note) : Failure(note.errors.to_hash(true))
      end

      def serialize_result(note)
        Success(
          ApiCurrent::Notes::NoteFacade
            .new(note: note)
            .then { ApiCurrent::Notes::NoteSerializer.new(_1).build_schema }
        )
      end
    end
  end
end
