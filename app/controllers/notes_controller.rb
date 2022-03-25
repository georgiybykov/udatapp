# frozen_string_literal: true

class NotesController < ApplicationController
  include Udatapp::Import[fetch_notes_list: 'services.notes.index',
                          show_note: 'services.notes.show',
                          create_note: 'services.notes.create',
                          update_note: 'services.notes.update',
                          destroy_note: 'services.notes.destroy']

  def index
    perform { fetch_notes_list.call }
  end

  def show
    perform { show_note.call(note_id: params[:id], current_user: current_user) }
  end

  def create
    perform { create_note.call(params: params.to_unsafe_hash, current_user: current_user) }
  end

  def update
    perform { update_note.call(note_id: params[:id], params: params.to_unsafe_hash, current_user: current_user) }
  end

  def destroy
    perform { destroy_note.call(note_id: params[:id], current_user: current_user) }
  end
end
