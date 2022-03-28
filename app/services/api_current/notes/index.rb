# frozen_string_literal: true

module ApiCurrent
  module Notes
    class Index
      include Dry::Monads[:result]

      # @return [Dry::Monads::Result<Hash>]
      def call(*)
        notes = Note.not_private.to_a

        Success(
          notes
            .map! { ApiCurrent::Notes::NoteFacade.new(note: _1) }
            .then { ApiCurrent::Notes::NotesListSerializer.new({ list: _1 }).build_schema }
        )
      end
    end
  end
end
