# frozen_string_literal: true

module Notes
  class UpdateNoteContract < BaseContract
    json do
      optional(:title).filled(:string)
      optional(:body).filled(:string)
      optional(:private).filled(:bool)
    end
  end
end
