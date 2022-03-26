# frozen_string_literal: true

require 'dry/auto_inject'

require './lib/udatapp/api_current_container'

module Udatapp
  Import = Dry::AutoInject(Container)
end
