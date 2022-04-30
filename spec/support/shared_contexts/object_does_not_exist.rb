# frozen_string_literal: true

shared_context 'when object not found by ID' do |api_version = :api_current|
  response '422', 'when object with the given ID does not exist' do
    let(:id) { 0 }

    before { login_as(user, version: api_version) }

    schema '$ref': '#/components/schemas/error'

    run_test! do
      expect(response_json).to eq({ error: 'not_found' })
    end
  end
end
