# frozen_string_literal: true

describe ApiCurrent::Notes::NoteFacade, type: :facade, with: :time do
  subject(:facade) { described_class.new(note: note) }

  let(:note) do
    freeze_time = Time.zone.local(2022, 0o3, 25, 11, 45, 0o0)

    travel_to(freeze_time) do
      create(:note, title: 'Note title', body: 'Note body', private: true)
    end
  end

  describe '#id' do
    it { expect(facade.id).to eq(note.id) }
  end

  describe '#title' do
    it { expect(facade.title).to eq('Note title') }
  end

  describe '#body' do
    it { expect(facade.body).to eq('Note body') }
  end

  describe '#public' do
    it { expect(facade.public).to be(false) }
  end

  describe '#published_at' do
    it { expect(facade.published_at).to eq('2022-03-25T11:45:00+03:00') }
  end
end
