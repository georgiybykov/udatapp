# frozen_string_literal: true

class NotesController < ApplicationController
  def index
    notes = Note.not_private.to_a

    facades = notes.map! { Notes::AuthenticationInfoFacade.new(note: _1) }

    render json: { list: Notes::NotesListSerializer.new(facades).build_schema }, status: :ok
  end

  def show
    # validate params
    # find note
    # serialize result

    note = find_by(id: params[:id])

    render json: note, status: :ok
  end

  def create
    # validate params
    # create note
    # return response 201
  end

  def update
    # validate params
    # check policy
    # update note
    # return response 200
  end

  def destroy
    # validate params
    # check policy
    # destroy note
    # return response 200
  end
end
