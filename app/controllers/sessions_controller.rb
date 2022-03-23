# frozen_string_literal: true

class SessionsController < ApplicationController
  include Udatapp::Import['services.sessions.authenticate_user']

  skip_before_action :authenticate_request!

  def create
    result = authenticate_user.call(email: params[:email], password: params[:password])

    # TODO: temporary with hashes - refactor further
    if result.include?(:auth_token)
      render json: result, status: :created
    else
      render json: { code: :access_token_not_created, errors: result }, status: :unauthorized
    end
  end
end
