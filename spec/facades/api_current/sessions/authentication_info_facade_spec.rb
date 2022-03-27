# frozen_string_literal: true

describe ApiCurrent::Sessions::AuthenticationInfoFacade, type: :facade do
  subject(:facade) { described_class.new(access_token: access_token, expiration_time: expiration_time) }

  let(:access_token) { 'token_example' }
  let(:expiration_time) { Time.zone.local(2022, 0o1, 27, 12, 45, 0o0) }

  describe '#access_token' do
    it { expect(facade.access_token).to eq('token_example') }
  end

  describe '#expires_at' do
    it { expect(facade.expires_at).to eq('2022-01-27T12:45:00+03:00') }
  end
end
