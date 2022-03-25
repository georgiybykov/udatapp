# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request!

  def create
    user = User.new(user_params)

    if user.save
      render json: {}, status: :created
    else
      render json: { error: :not_created, errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
