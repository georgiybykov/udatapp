# frozen_string_literal: true

class SessionsController < ApplicationController
  include Udatapp::Import['services.sessions.authenticate_user']

  skip_before_action :authenticate_request!

  def create
    perform(status: :created) { authenticate_user.call(params: params.to_unsafe_hash) }
  end
end
