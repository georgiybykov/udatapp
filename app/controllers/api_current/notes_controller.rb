# frozen_string_literal: true

module ApiCurrent
  class NotesController < ApplicationController
    include Udatapp::Import[fetch_notes_list: 'services.api_current.notes.index',
                            show_note: 'services.api_current.notes.show',
                            create_note: 'services.api_current.notes.create',
                            update_note: 'services.api_current.notes.update',
                            destroy_note: 'services.api_current.notes.destroy']

    def index
      perform { fetch_notes_list.call }
    end

    def show
      perform { show_note.call(note_id: params[:id], current_user: current_user) }
    end

    def create
      perform(status: :created) { create_note.call(params: params.to_unsafe_hash, current_user: current_user) }
    end

    def update
      perform { update_note.call(note_id: params[:id], params: params.to_unsafe_hash, current_user: current_user) }
    end

    def destroy
      perform { destroy_note.call(note_id: params[:id], current_user: current_user) }
    end
  end
end
