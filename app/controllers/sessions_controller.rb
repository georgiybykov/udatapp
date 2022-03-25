# frozen_string_literal: true

class SessionsController < ApplicationController
  include Udatapp::Import['services.sessions.authenticate_user']

  skip_before_action :authenticate_request!

  def create
    case authenticate_user.call(params: params.to_unsafe_hash)
    in Success(result)
      render json: result, status: :created
    in Failure(error)
      render json: { error: error }, status: :unauthorized
    end
  end
end
