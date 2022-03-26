# frozen_string_literal: true

module ApiV1
  module Notes
    class UpdateNoteContract < BaseContract
      json do
        optional(:title).filled(:string)
        optional(:body).filled(:string)
        optional(:private).filled(:bool)
      end
    end
  end
end
