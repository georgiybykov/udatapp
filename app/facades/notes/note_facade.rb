# frozen_string_literal: true

module Notes
  class AuthenticationInfoFacade
    def initialize(note:)
      @note = note
    end

    delegate :title, to: :note

    delegate :body, to: :note

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
