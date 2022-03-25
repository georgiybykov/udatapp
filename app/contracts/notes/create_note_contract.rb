# frozen_string_literal: true

module Notes
  class CreateNoteContract < BaseContract
    json do
      required(:title).filled(:string)
      required(:body).filled(:string)
      optional(:private).filled(:bool)
    end
  end
end
