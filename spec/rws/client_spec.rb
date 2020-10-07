# frozen_string_literal: true

require 'spec_helper'

require 'rws/client'

RSpec.describe RWS::Client do
  subject(:client) { described_class.new(io) }

  describe '#close' do
    let(:io) { IO.new(fd, 'r') }
    let(:fd) { IO.sysopen('/dev/zero', 'r') }

    it 'closes opened IO stream' do
      expect { client.close }.to change { io.closed? }.from(false).to(true)
    end
  end

  describe '#send_response' do
    let(:io) { IO.new(fd, 'w') }
    let(:fd) { IO.sysopen('/dev/null', 'w') }
    let(:response) { 'RWS is cool!' }

    before { allow(io).to receive(:print).with(response).and_call_original }

    it 'writes passed response to IO stream' do
      client.send_response(response)

      expect(io).to have_received(:print).with(response)
    end
  end
end
