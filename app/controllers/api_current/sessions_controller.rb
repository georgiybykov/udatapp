# frozen_string_literal: true

module ApiCurrent
  class SessionsController < ApplicationController
    include Udatapp::Import['services.api_current.sessions.authenticate_user']

    skip_before_action :authenticate_request!

    def create
      perform(status: :created) { authenticate_user.call(params: params.to_unsafe_hash) }
    end
  end
end
