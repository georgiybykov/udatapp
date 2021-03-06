# frozen_string_literal: true

describe User, type: :model do
  it { is_expected.to have_many(:notes).dependent(:destroy) }

  it { is_expected.to validate_presence_of :email }

  it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:password_digest).of_type(:string).with_options(null: false) }
end
