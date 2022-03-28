# frozen_string_literal: true

describe ApiCurrent::Notes::Create, type: :service, aggregate_failures: true do
  include Dry::Monads[:result]

  subject(:result) { described_class.new.call(params: params, current_user: user) }

  let(:params) do
    {
      title: 'New note title',
      body: 'New note body',
      private: true
    }
  end

  let(:user) { create(:user) }

  context 'when params are invalid' do
    let(:params) do
      {
        title: nil,
        body: 1,
        private: 0
      }
    end

    it 'returns Failure monad with errors' do
      expect(result.failure).to be_a(Dry::Validation::Result)

      expect(result.failure.errors.to_h).to eq({
                                                 title: ['must be a string'],
                                                 body: ['must be a string'],
                                                 private: ['must be boolean']
                                               })
    end
  end

  context 'when note has not been created' do
    before { create(:note, title: 'New note title') }

    it 'does not save the note to DB and returns Failure monad with errors' do
      expect(result).to eq(Failure({ title: 'has already been taken' }))
    end
  end

  context 'when everything is OK' do
    it 'creates a note' do
      serialized_result = result.success

      expect(serialized_result[:title]).to eq('New note title')
      expect(serialized_result[:body]).to eq('New note body')
      expect(serialized_result[:public]).to be(false)
    end
  end
end
