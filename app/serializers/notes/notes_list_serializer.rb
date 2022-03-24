# frozen_string_literal: true

module Notes
  class NotesListSerializer < BaseSerializer
    json_schema do
      {
        list: Types::Array.of(
          Types::Strict::Hash.schema(
            Notes::NoteSerializer.defined_schema
          )
        )
      }
    end

    def list
      Notes::NoteSerializer.new(object.list).build_schema
    end
  end
end
