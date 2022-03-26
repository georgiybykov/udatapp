# frozen_string_literal: true

module ApiV1
  module Notes
    class Update
      include Dry::Monads[:result, :maybe, :do]

      include Udatapp::Import[contract: 'contracts.api_v1.notes.update_note_contract']

      # @param note_id [Integer]
      # @param params [Hash]
      # @param current_user [User]
      #
      # @return [Dry::Monads::Result<Hash, Symbol>]
      def call(note_id:, params:, current_user:)
        form = yield contract.call(params)

        note = yield find_note(note_id).to_result(:not_found)

        yield check_policy!(note, current_user)

        note = yield update_note!(note, form.to_h)

        serialize_result(note)
      end

      private

      def find_note(note_id)
        note = Note.find_by(id: note_id) or return None()

        Some(note)
      end

      def check_policy!(note, current_user)
        return Failure(:access_denied) if not_current_user_note?(note, current_user)

        Success()
      end

      def not_current_user_note?(note, user)
        note.user_id != user.id
      end

      def update_note!(note, attributes)
        note.update(attributes) ? Success(note) : Failure(note.errors.to_h)
      end

      def serialize_result(note)
        Success(
          ApiV1::Notes::NoteFacade
            .new(note: note)
            .then { ApiV1::Notes::NoteSerializer.new(_1).build_schema }
        )
      end
    end
  end
end
