# frozen_string_literal: true

module ApiCurrent
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
