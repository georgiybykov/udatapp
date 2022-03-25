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

    register('services.sessions.authorize_api_request') { Sessions::AuthorizeApiRequest.new }
    register('services.sessions.authenticate_user') { Sessions::AuthenticateUser.new }

    register('contracts.sessions.authenticate_user_contract') { Sessions::AuthenticateUserContract.new }

    register('services.notes.show') { Notes::Show.new }
    register('services.notes.create') { Notes::Create.new }
    register('services.notes.update') { Notes::Update.new }
    register('services.notes.destroy') { Notes::Destroy.new }

    register('contracts.notes.create_note_contract') { Notes::CreateNoteContract.new }
    register('contracts.notes.update_note_contract') { Notes::UpdateNoteContract.new }
  end
end
