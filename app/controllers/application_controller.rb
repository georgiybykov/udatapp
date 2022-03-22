# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request!

  rescue_from ActiveRecord::RecordNotFound do
    render json: { code: :user_not_found }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do
    render json: { code: :invalid_record }, status: :bad_request
  end

  private

  def authenticate_request!
    return if current_user

    render json: { code: :invalid_access_token }, status: :unauthorized
  end

  def current_user
    @current_user ||= Sessions::AuthorizeApiRequest.new.call(auth_header: request.headers['Authorization'])
  end
end
