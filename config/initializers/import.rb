# frozen_string_literal: true

require 'dry/auto_inject'

require './lib/udatapp/container'
require './lib/udatapp/api_current_container'
require './lib/udatapp/api_v1_container'

module Udatapp
  Import = Dry::AutoInject(Container)
end
