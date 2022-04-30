# frozen_string_literal: true

require 'dry/container'

module Udatapp
  class Container
    extend ::Dry::Container::Mixin

    class MemoizingRegistry < Dry::Container::Registry
      DEFAULT_MEMOIZATION_OPTION = { memoize: true }.freeze

      def call(container, key, item, options)
        super(container, key, item, DEFAULT_MEMOIZATION_OPTION.merge(options))
      end
    end

    config.registry = MemoizingRegistry.new
  end
end
