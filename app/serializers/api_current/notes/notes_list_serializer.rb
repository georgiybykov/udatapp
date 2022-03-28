# frozen_string_literal: true

module ApiCurrent
  module Notes
    class NotesListSerializer < BaseSerializer
      json_schema do
        {
          list: Types::Array.of(
            Types::Strict::Hash.schema(
              ApiCurrent::Notes::NoteSerializer.defined_schema
            )
          )
        }
      end

      def list
        ApiCurrent::Notes::NoteSerializer.new(object.list).build_schema
      end
    end
  end
end
