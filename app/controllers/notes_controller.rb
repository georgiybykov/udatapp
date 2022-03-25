# frozen_string_literal: true

class NotesController < ApplicationController
  include Udatapp::Import[show_note: 'services.notes.show',
                          create_note: 'services.notes.create',
                          update_note: 'services.notes.update']

  def index
    notes = Note.not_private.to_a

    facades = notes.map! { Notes::NoteFacade.new(note: _1) }

    render json: Notes::NotesListSerializer.new({ list: facades }).build_schema, status: :ok
  end

  def show
    case show_note.call(note_id: params[:id], current_user: current_user)
    in Success(result)
      render json: result, status: :ok
    in Failure(:access_denied)
      render json: { error: :access_denied }, status: :forbidden
    in Failure(:note_not_found)
      render json: { error: :note_not_found }, status: :unprocessable_entity
    end
  end

  def create
    case create_note.call(params: params.to_unsafe_hash, current_user: current_user)
    in Success()
      render json: {}, status: :created
    in Failure(error)
      render json: { error: error }, status: :unprocessable_entity
    end
  end

  def update
    case update_note.call(note_id: params[:id], params: params.to_unsafe_hash, current_user: current_user)
    in Success()
      render json: {}, status: :ok
    in Failure(:access_denied)
      render json: { error: :access_denied }, status: :forbidden
    in Failure(:note_not_found)
      render json: { error: :note_not_found }, status: :unprocessable_entity
    in Failure(error)
      render json: { error: error }, status: :unprocessable_entity
    end
  end

  def destroy
    # validate params
    # check policy
    # destroy note
    # return response 200
  end
end
