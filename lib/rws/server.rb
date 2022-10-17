# frozen_string_literal: true

require 'socket'

require 'rws'
require 'rws/client'
require 'rws/configuration'
require 'rws/response'
require 'rws/request'

module RWS
  class Server
    DEFAULT_HOST = '0.0.0.0'
    DEFAULT_PORT = 7890

    def initialize(host: DEFAULT_HOST, port: DEFAULT_PORT, config: nil)
      @host = host
      @port = port
      @config = RWS::Configuration.new(config).load
    end

    def run
      TCPServer.open(@host, @port) do |server|
        puts "RWS version #{RWS::VERSION} started, host: #{@host}, port: #{@port}"
        serve_clients(server)
      rescue Interrupt
        shutdown
      end
    end

    private

    def serve_clients(server)
      loop do
        client = next_client(server)
        break unless client

        response = handle_request(client)
        send_response(client, response)

        client.close
      end
    end

    def next_client(server)
      io = server.accept
      return unless io

      RWS::Client.new(io)
    end

    def handle_request(client)
      request = RWS::Request.new(client).handle!

      puts "[#{Time.now}] #{request.method} '#{request.url}'"
      puts 'Headers:'
      puts request.headers.map { |header, value| "\t#{header}: #{value}" }.join("\n")

      RWS::Response.new({ request: request }, @config[:app]).build
    end

    def send_response(client, response)
      client.send_response(response)
    end

    def shutdown
      puts "\nServer is down"

      exit 0
    end
  end
end
