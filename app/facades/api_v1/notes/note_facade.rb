# frozen_string_literal: true

module ApiV1
  module Notes
    class NoteFacade
      def initialize(note:)
        @note = note
      end

      delegate :id, :title, :body, to: :note

      def public
        !note.private?
      end

      def published_at
        note.created_at.iso8601
      end

      private

      # @return [Note]
      attr_reader :note
    end
  end
end
