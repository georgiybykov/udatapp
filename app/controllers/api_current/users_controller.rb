# frozen_string_literal: true

module ApiCurrent
  class UsersController < ApplicationController
    include Udatapp::Import[create_user: 'services.api_current.users.create']

    skip_before_action :authenticate_request!

    def create
      perform(status: :created) { create_user.call(params: params.to_unsafe_hash) }
    end
  end
end
