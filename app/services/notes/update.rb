# frozen_string_literal: true

module Notes
  class Update
    include Dry::Monads[:result, :do]

    include Udatapp::Import[contract: 'contracts.notes.update_note_contract']

    # @param note_id [Integer]
    # @param params [Hash]
    # @param current_user [User]
    #
    # @return [Dry::Monads::Result<Hash, Symbol>]
    def call(note_id:, params:, current_user:)
      form = yield validate!(params)

      note = yield find_note(note_id)

      yield check_policy!(note, current_user)

      note = yield update_note!(note, form)

      serialize_result(note)
    end

    private

    def validate!(params)
      result = contract.call(params)

      return Failure(result.errors.to_h) if result.failure?

      Success(result.to_h)
    end

    def find_note(note_id)
      note = Note.find_by(id: note_id)

      return Failure(:not_found) unless note

      Success(note)
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
        Notes::NoteFacade.new(note: note)
                         .then { Notes::NoteSerializer.new(_1).build_schema }
      )
    end
  end
end
