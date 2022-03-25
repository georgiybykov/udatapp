# frozen_string_literal: true

module Responder
  extend ActiveSupport::Concern

  include Dry::Monads[:result]

  def perform(status: :ok)
    raise 'No bock given to the Responder' unless block_given?

    case yield
    in Success(result)
      render json: result, status: status
    in Failure(:access_denied)
      render json: { error: :access_denied }, status: :forbidden
    in Failure(:not_found)
      render json: { error: :not_found }, status: :unprocessable_entity
    in Failure(error)
      render json: { error: error }, status: :unprocessable_entity
    end
  end
end
