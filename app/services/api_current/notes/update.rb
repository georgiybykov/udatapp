# frozen_string_literal: true

module ApiCurrent
  module Notes
    class Update
      include Dry::Monads[:result, :maybe, :do]

      include Udatapp::Import[contract: 'contracts.api_current.notes.update_note_contract']

      # @param note_id [Integer]
      # @param params [Hash]
      # @param current_user [User]
      #
      # @return [Dry::Monads::Result<Hash, Symbol>]
      def call(note_id:, params:, current_user:)
        form = yield contract.call(params)

        note = yield find_note(note_id).to_result(:not_found)

        yield check_policy!(note, current_user)

        yield update_note!(note, form.to_h)

        Success({})
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
    end
  end
end
