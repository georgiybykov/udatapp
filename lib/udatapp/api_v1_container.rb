# frozen_string_literal: true

container = Udatapp::Container

container.register('services.api_v1.sessions.authorize_api_request') { ApiV1::Sessions::AuthorizeApiRequest.new }

container.register('services.api_v1.notes.update') { ApiV1::Notes::Update.new }

container.register('contracts.api_v1.notes.update_note_contract') { ApiV1::Notes::UpdateNoteContract.new }
