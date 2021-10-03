# frozen_string_literal: true

require 'rws/parser'

module RWS
  class Request
    attr_reader :client_io, :headers, :method, :protocol_version, :url

    def initialize(client)
      @client_io = client.io
    end

    def handle!
      @method, @url, @protocol_version = RWS::Parser.parse_start_line(client_io)
      @headers = RWS::Parser.parse_headers(client_io)

      self
    end
  end
end
