# frozen_string_literal: true

require 'swagger_helper'

describe 'The notes for user API', swagger_doc: 'api_v1/swagger.yaml',
                                   spec_type: :api,
                                   with: :time,
                                   aggregate_failures: true do
  let(:Authorization) { 'Bearer token example' } # rubocop:disable RSpec/VariableName

  let(:user) { create(:user) }

  let!(:note) do
    freeze_time = Time.zone.local(2022, 0o3, 27, 10, 47, 0o0)

    travel_to(freeze_time) { create(:note, :public, title: 'Note title', body: 'Note body', user: user) }
  end

  let!(:second_note) { create(:note, :public, title: 'Second note title', body: 'Second note body') }

  path '/notes/{id}' do
    patch 'Updates the selected note' do
      consumes 'application/json'
      produces 'application/json'

      tags 'Notes'

      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'
      parameter name: :id, in: :path, type: :string, required: true, description: 'id of the selected note'
      parameter name: :params, in: :body, required: false, schema: {
        type: :object,
        additionalProperties: false,
        properties: {
          properties: {
            title: { type: :string },
            body: { type: :string },
            private: { type: :boolean }
          }
        }
      }

      let(:id) { note.id }

      let(:params) do
        {
          title: 'Currently updated note title',
          body: 'Currently updated note body',
          private: true
        }
      end

      response '200', 'with valid setup' do
        before { login_as(user, version: :api_v1) }

        schema type: :object

        run_test! do
          expect(response_json).to eq({
                                        id: note.id,
                                        title: 'Currently updated note title',
                                        body: 'Currently updated note body',
                                        public: false,
                                        published_at: '2022-03-27T10:47:00+03:00'
                                      })

          note.reload

          expect(note.title).to eq('Currently updated note title')
          expect(note.body).to eq('Currently updated note body')
          expect(note.private?).to be(true)
        end
      end

      response '422', 'with invalid params' do
        let(:params) do
          {
            title: 1,
            body: nil,
            private: 'invalid'
          }
        end

        before { login_as(user, version: :api_v1) }

        schema '$ref': '#/components/schemas/note_contract_error'

        run_test! do
          expect(response_json).to eq({
                                        title: ['must be a string'],
                                        body: ['must be a string'],
                                        private: ['must be boolean']
                                      })
        end
      end

      response '403', 'when the author of the note is another user' do
        let(:id) { second_note.id }

        before { login_as(user, version: :api_v1) }

        schema '$ref': '#/components/schemas/error'

        run_test! do
          expect(response_json).to eq({ error: 'access_denied' })
        end
      end

      include_examples 'unauthorized user'
      include_context 'when object not found by ID', :api_v1
    end
  end
end
