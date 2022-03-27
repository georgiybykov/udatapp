# frozen_string_literal: true

describe Note, type: :model, aggregate_failures: true do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }

  it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:body).of_type(:text).with_options(null: false) }
  it { is_expected.to have_db_column(:private).of_type(:boolean).with_options(null: false, default: false) }

  context 'with validates uniqueness of the title' do
    before { create(:note, title: 'First Note') }

    let(:build_note) { build(:note, title: 'First Note') }

    specify do
      expect(build_note).to validate_uniqueness_of :title

      expect { build_note.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
