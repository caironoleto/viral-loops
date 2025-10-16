# frozen_string_literal: true

require 'viral_loops'

RSpec.describe ViralLoops::Resources::Participants do
  context 'with a successful response' do
    let(:valid_params) { { user: { firstname: 'Cairo', lastname: 'Noleto', email: 'cairo@kompra.app' } } }
    let(:valid_response) { { referralCode: 'XYZ123', isNew: true } }

    before do
      stub_request(:post, 'https://app.viral-loops.com/api/v3/campaign/participant')
        .to_return(status: 200, body: valid_response.to_json)
    end

    it 'returns a participant' do
      participant = subject.create(valid_params)

      expect(participant).to be_a(ViralLoops::Models::Participant)
      expect(participant.referral_code).to eq('XYZ123')
    end
  end

  context 'with a failure response' do
    let(:invalid_response) { { message: 'Something went wrong' } }

    before do
      stub_request(:post, 'https://app.viral-loops.com/api/v3/campaign/participant')
        .to_return(status: 500, body: invalid_response.to_json)
    end

    it 'raises an error' do
      expect { subject.create(user: { firstname: 'Cairo' }) }.to raise_error do |error|
        expect(error).to be_a(ViralLoops::ApiError)
        expect(error.status).to eq(500)
        expect(error.status_symbol).to eq(:internal_server_error)
        expect(error.body).to eq('{"message":"Something went wrong"}')
      end
    end
  end

  context 'with a another failure response' do
    let(:invalid_response) { { error: 'Something went wrong' } }

    before do
      stub_request(:post, 'https://app.viral-loops.com/api/v3/campaign/participant')
        .to_return(status: 500, body: '')
    end

    it 'raises an error' do
      expect { subject.create(user: { firstname: 'Cairo' }) }.to raise_error do |error|
        expect(error).to be_a(ViralLoops::ApiError)
        expect(error.status).to eq(500)
        expect(error.status_symbol).to eq(:internal_server_error)
        expect(error.body).to include('Internal Server Error')
      end
    end
  end
end
