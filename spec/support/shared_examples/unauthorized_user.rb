# frozen_string_literal: true

shared_examples 'unauthorized user' do
  response '401', 'when user is not authenticated' do
    schema '$ref': '#/components/schemas/error'

    run_test! do
      expect(response_json).to eq({ error: 'invalid_access_token' })
    end
  end
end
