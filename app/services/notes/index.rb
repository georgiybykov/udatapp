# frozen_string_literal: true

module Notes
  class Index
    include Dry::Monads[:result]

    # @return [Dry::Monads::Result<Hash>]
    def call(*)
      notes = Note.not_private.to_a

      Success(
        notes
          .map! { Notes::NoteFacade.new(note: _1) }
          .then { Notes::NotesListSerializer.new({ list: _1 }).build_schema }
      )
    end
  end
end
