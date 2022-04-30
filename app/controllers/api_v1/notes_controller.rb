# frozen_string_literal: true

module ApiV1
  class NotesController < ApplicationController
    include Udatapp::Import[update_note: 'services.api_v1.notes.update']

    def update
      perform { update_note.call(note_id: params[:id], params: params.to_unsafe_hash, current_user: current_user) }
    end
  end
end
