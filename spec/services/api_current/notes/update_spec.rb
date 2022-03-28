# frozen_string_literal: true

describe ApiCurrent::Notes::Update, type: :service, aggregate_failures: true do
  include Dry::Monads[:result, :maybe]

  subject(:result) { described_class.new.call(note_id: note_id, params: params, current_user: current_user) }

  let(:note_id) { note.id }

  let(:params) do
    {
      title: 'New note title',
      body: 'New note body',
      private: true
    }
  end

  let(:current_user) { user }

  let(:user) { create(:user) }

  let(:note) { create(:note, title: 'Old note title', body: 'Old note body', private: false, user: user) }

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

  context 'when the note has not been found' do
    let(:note_id) { -1 }

    it { is_expected.to eq(Failure(:not_found)) }
  end

  context 'when the user has no ability to update the selected note' do
    let(:current_user) { another_user }

    let(:another_user) { create(:user) }

    it { is_expected.to eq(Failure(:access_denied)) }
  end

  context 'when note has not been updated' do
    before { create(:note, title: 'New note title') }

    it 'does not update the note and returns Failure monad with errors' do
      expect(result).to eq(Failure({ title: 'has already been taken' }))
    end
  end

  context 'when everything is OK' do
    it 'updates a note' do
      expect(result).to eq(Success({}))

      note.reload

      expect(note.title).to eq('New note title')
      expect(note.body).to eq('New note body')
      expect(note.private?).to be(true)
    end
  end
end
