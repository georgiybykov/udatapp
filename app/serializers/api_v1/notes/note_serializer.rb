# frozen_string_literal: true

module ApiV1
  module Notes
    class NoteSerializer < BaseSerializer
      json_schema do
        {
          id: Types::Strict::Integer,
          title: Types::Strict::String,
          body: Types::Strict::String,
          public: Types::Strict::Bool,
          published_at: Types::Strict::String
        }
      end
    end
  end
end
