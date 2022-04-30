# frozen_string_literal: true

module ApiHelpers
  def login_as(user, version: :api_current)
    allow(Udatapp::Container["services.#{version}.sessions.authorize_api_request"])
      .to receive(:call).and_return(Some(user))
  end

  def response_json
    @response_json ||= JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include Dry::Monads[:maybe], spec_type: :api
  config.include ApiHelpers, spec_type: :api
end
