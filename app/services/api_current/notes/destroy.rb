# frozen_string_literal: true

module ApiCurrent
  module Notes
    class Destroy
      include Dry::Monads[:result, :maybe, :do]

      # @param note_id [Integer]
      # @param current_user [User]
      #
      # @return [Dry::Monads::Result<Note, Symbol>]
      def call(note_id:, current_user:)
        note = yield find_note(note_id).to_result(:not_found)

        yield check_policy!(note, current_user)

        note.destroy!

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
    end
  end
end
