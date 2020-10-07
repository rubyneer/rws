# frozen_string_literal: true

require 'spec_helper'

require 'rws/parser'

RSpec.describe RWS::Parser do
  let(:io) { StringIO.new(request) }
  let(:request) do
    <<~START_LINE
      GET / HTTP/1.1
      Content-Type: text/html

    START_LINE
  end

  describe '.parse_start_line' do
    subject(:parse_start_line) { described_class.parse_start_line(io) }

    it 'parses start line and returns her elements' do
      expect(parse_start_line).to contain_exactly('GET', '/', 'HTTP/1.1')
    end
  end

  describe '.parse_headers' do
    subject(:parse_headers) { described_class.parse_headers(io) }

    it 'parses headers and return them as Hash' do
      expect(parse_headers).to include('Content-Type')
    end
  end
end
