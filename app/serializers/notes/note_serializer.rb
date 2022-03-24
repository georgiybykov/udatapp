# frozen_string_literal: true

module Notes
  class NoteSerializer < BaseSerializer
    json_schema do
      {
        title: Types::Strict::String,
        body: Types::Strict::String,
        public: Types::Strict::Bool,
        published_at: Types::Strict::String
      }
    end
  end
end
