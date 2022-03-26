# frozen_string_literal: true

container = Udatapp::Container

container.register('services.api_current.sessions.authorize_api_request') { ApiCurrent::Sessions::AuthorizeApiRequest.new }
container.register('services.api_current.sessions.authenticate_user') { ApiCurrent::Sessions::AuthenticateUser.new }

container.register('contracts.api_current.sessions.authenticate_user_contract') { ApiCurrent::Sessions::AuthenticateUserContract.new }

container.register('services.api_current.notes.index') { ApiCurrent::Notes::Index.new }
container.register('services.api_current.notes.show') { ApiCurrent::Notes::Show.new }
container.register('services.api_current.notes.create') { ApiCurrent::Notes::Create.new }
container.register('services.api_current.notes.update') { ApiCurrent::Notes::Update.new }
container.register('services.api_current.notes.destroy') { ApiCurrent::Notes::Destroy.new }

container.register('contracts.api_current.notes.create_note_contract') { ApiCurrent::Notes::CreateNoteContract.new }
container.register('contracts.api_current.notes.update_note_contract') { ApiCurrent::Notes::UpdateNoteContract.new }
