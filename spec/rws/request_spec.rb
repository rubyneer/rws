# frozen_string_literal: true

require 'spec_helper'

require 'rws/client'
require 'rws/request'

RSpec.describe RWS::Request do
  describe '#handle!' do
    subject(:request) { described_class.new(client) }

    let(:client) { RWS::Client.new(StringIO.new(http_request)) }
    let(:http_request) do
      <<~HTTP_REQUEST
        GET / HTTP/1.1
        Content-Type: text/html

      HTTP_REQUEST
    end

    specify do
      request.handle!

      expect(request).to have_attributes(
        method: eq('GET'),
        protocol_version: eq('HTTP/1.1'),
        url: eq('/'),
        headers: eq({ 'Content-Type' => 'text/html' })
      )
    end
  end
end
