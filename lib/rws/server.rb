# frozen_string_literal: true

require 'socket'

require 'rws'
require 'rws/client'
require 'rws/parser'

module RWS
  class Server
    DEFAULT_HOST = '0.0.0.0'
    DEFAULT_PORT = 7890

    def initialize(host: nil, port: nil)
      @host = host || DEFAULT_HOST
      @port = port || DEFAULT_PORT
    end

    def run
      TCPServer.open(@host, @port) do |server|
        puts "RWS version #{RWS::VERSION} started, host: #{@host}, port: #{@port}"
        handle_clients(server)
      rescue Interrupt
        shutdown
      end
    end

    private

    def handle_clients(server)
      loop do
        client = get_client(server)
        break unless client

        handle_request(client)
        client.send_response(response.to_s)

        client.close
      end
    end

    def get_client(server)
      io = server.accept
      return unless io

      RWS::Client.new(io)
    end

    def handle_request(client)
      method, url, protocol_version = RWS::Parser.parse_start_line(client.io)
      headers = RWS::Parser.parse_headers(client.io)

      puts "[#{Time.now}] #{protocol_version} #{method} '#{url}'"
      puts 'Headers:'
      puts headers.map { |header, value| "\t#{header}: #{value}" }.join("\n")
    end

    def response # rubocop:disable Metrics/MethodLength
      status = '200'
      headers = { 'Content-Type' => 'text/html' }
      body = <<~HTML
        <!doctype html>
        <html>
          <head>
            <meta content="text/html; charset=UTF-8">
            <title>Welcome to RWS!</title>
          </head>
          <body>
            <h1>Welcome to RWS!</h1>
          </body>
        </html>
      HTML

      [start_line(status), prepare_headers(headers), '', body].join("\r\n")
    end

    def start_line(status)
      "HTTP/1.1 #{status}"
    end

    def prepare_headers(headers)
      headers.map { |name, value| "#{name}: #{value}" }.join("\n")
    end

    def shutdown
      puts "\nServer is down"

      exit 0
    end
  end
end
