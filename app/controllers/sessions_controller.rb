# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_request!

  def create
    result = Sessions::AuthenticateUser.new.call(email: params[:email], password: params[:password])

    # TODO: temporary with hashes - refactor further
    if result.include?(:auth_token)
      render json: result, status: :created
    else
      render json: { code: :access_token_not_created, errors: result }, status: :unauthorized
    end
  end
end
