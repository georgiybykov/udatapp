# frozen_string_literal: true

module Notes
  class Show
    include Dry::Monads[:result, :do]

    # @param note_id [Integer]
    # @param current_user [User]
    #
    # @return [Dry::Monads::Result<Hash, Symbol>]
    def call(note_id:, current_user:)
      note = yield find_note(note_id)

      yield check_policy!(note, current_user)

      serialize_result(note)
    end

    private

    def find_note(note_id)
      note = Note.find_by(id: note_id)

      return Failure(:not_found) unless note

      Success(note)
    end

    def check_policy!(note, current_user)
      return Failure(:access_denied) if note.private? && not_current_user_note?(note, current_user)

      Success()
    end

    def not_current_user_note?(note, user)
      note.user_id != user.id
    end

    def serialize_result(note)
      Success(
        Notes::NoteFacade.new(note: note)
          .then { Notes::NoteSerializer.new(_1).build_schema }
      )
    end
  end
end
