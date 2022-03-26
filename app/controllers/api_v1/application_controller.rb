# frozen_string_literal: true

module ApiV1
  class ApplicationController < ActionController::API
    include ApiV1::Concerns::Responder

    include Udatapp::Import['services.api_v1.sessions.authorize_api_request']

    before_action :authenticate_request!

    rescue_from ActiveRecord::RecordNotFound do
      render json: { error: :user_not_found }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do
      render json: { error: :invalid_record }, status: :bad_request
    end

    rescue_from NoMatchingPatternError do |exception|
      Rails.logger.error { "Exception details: #{exception}" }

      render json: {}, status: :internal_server_error
    end

    private

    def authenticate_request!
      return if current_user

      render json: { error: :invalid_access_token }, status: :unauthorized
    end

    def current_user
      @current_user ||= authorize_api_request
                          .call(auth_header: request.headers['Authorization'])
                          .value_or(nil)
    end
  end
end
